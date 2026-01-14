const express = require("express");
const path = require("path");

const { Pool } = require("pg");
const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const app = express();
app.use(express.json());

// ---- Serve your HTML from ./wiki (copied by Dockerfile)
const WIKI_DIR = path.join(__dirname, "wiki");
app.use(express.static(WIKI_DIR));

// If your landing page file is named differently, update these two lines
app.get("/", (req, res) => res.sendFile(path.join(WIKI_DIR, "index.html")));
app.get("/uploads", (req, res) => res.sendFile(path.join(WIKI_DIR, "uploads.html")));

// ---- Health endpoint (MUST match Dockerfile healthcheck)
app.get("/health", (req, res) => res.status(200).send("ok"));

// ---- Postgres (RDS)
function pgConfig() {
  // Optional support for DATABASE_URL
  if (process.env.DATABASE_URL) {
    return { connectionString: process.env.DATABASE_URL };
  }

  // DB creds injected as a secret env var containing JSON
  const secret = JSON.parse(process.env.DB_SECRET_JSON || "{}");

  return {
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT || 5432),
    user: secret.username,
    password: secret.password,
    database: secret.dbname,
    // If you want SSL to RDS, set DB_SSL=true in ECS env
    ssl: process.env.DB_SSL === "true" ? { rejectUnauthorized: false } : undefined,
  };
}

const pool = new Pool(pgConfig());

// ---- S3 presign
const s3 = new S3Client({ region: process.env.AWS_REGION });
const UPLOADS_BUCKET = process.env.UPLOADS_BUCKET;

function safePart(s = "") {
  return String(s)
    .trim()
    .replace(/^\/+|\/+$/g, "")
    .replace(/(\.\.)+/g, "")
    .replace(/[^a-zA-Z0-9/_-]/g, "");
}

// ---- Ensure tables exist (simple bootstrap)
async function ensureTables() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS uploads (
      id BIGSERIAL PRIMARY KEY,
      s3_key TEXT NOT NULL,
      filename TEXT NOT NULL,
      content_type TEXT,
      size_bytes BIGINT,
      team TEXT NOT NULL,
      folder TEXT NOT NULL,
      note TEXT,
      created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
  `);

  await pool.query(`
    CREATE INDEX IF NOT EXISTS idx_uploads_team_folder_created
    ON uploads(team, folder, created_at DESC);
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS invites (
      id BIGSERIAL PRIMARY KEY,
      email TEXT NOT NULL,
      team TEXT NOT NULL,
      created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    );
  `);

  await pool.query(`
    CREATE INDEX IF NOT EXISTS idx_invites_team_created
    ON invites(team, created_at DESC);
  `);
}

// ---- API: presign + store metadata
app.post("/api/uploads/presign", async (req, res) => {
  try {
    const { filename, contentType, size, team, folder, note } = req.body || {};
    if (!filename || !team || !folder) return res.status(400).send("Missing filename/team/folder");
    if (!UPLOADS_BUCKET) return res.status(500).send("UPLOADS_BUCKET not set");

    const t = safePart(team);
    const f = safePart(folder);
    const key = `uploads/${t}/${f}/${Date.now()}-${safePart(filename)}`;

    // Persist metadata for Recent uploads
    await pool.query(
      `INSERT INTO uploads (s3_key, filename, content_type, size_bytes, team, folder, note)
       VALUES ($1,$2,$3,$4,$5,$6,$7)`,
      [key, filename, contentType || null, size || null, t, f, (note || "").slice(0, 500)]
    );

    // Presign PUT
    const cmd = new PutObjectCommand({
      Bucket: UPLOADS_BUCKET,
      Key: key,
      ContentType: contentType || "application/octet-stream",
    });

    const uploadUrl = await getSignedUrl(s3, cmd, { expiresIn: 60 });
    res.json({ uploadUrl, key });
  } catch (e) {
    console.error(e);
    res.status(500).send(`presign error: ${e.message}`);
  }
});

// API: get recent
app.get("/api/uploads/recent", async (req, res) => {
  try {
    const team = safePart(req.query.team || "operations");
    const folder = safePart(req.query.folder || "general");

    const r = await pool.query(
      `SELECT filename, s3_key, size_bytes, team, folder, created_at
       FROM uploads
       WHERE team = $1 AND folder = $2
       ORDER BY created_at DESC
       LIMIT 8`,
      [team, folder]
    );

    res.json(r.rows);
  } catch (e) {
    console.error(e);
    res.status(500).send(`recent error: ${e.message}`);
  }
});

// API: clear recent (for team/folder)
app.delete("/api/uploads/recent", async (req, res) => {
  try {
    const team = safePart(req.query.team || "operations");
    const folder = safePart(req.query.folder || "general");

    await pool.query(`DELETE FROM uploads WHERE team=$1 AND folder=$2`, [team, folder]);
    res.status(204).send();
  } catch (e) {
    console.error(e);
    res.status(500).send(`delete recent error: ${e.message}`);
  }
});

// API: invite
app.post("/api/invites", async (req, res) => {
  try {
    const email = String(req.body?.email || "").trim();
    const team = safePart(req.body?.team || "operations");

    if (!email.includes("@")) return res.status(400).send("Invalid email");
    await pool.query(`INSERT INTO invites (email, team) VALUES ($1,$2)`, [email, team]);

    res.status(201).json({ ok: true });
  } catch (e) {
    console.error(e);
    res.status(500).send(`invite error: ${e.message}`);
  }
});

// ---- Start
const PORT = Number(process.env.PORT || 8080);

ensureTables()
  .then(() => {
    app.listen(PORT, () => console.log(`Server listening on ${PORT}`));
  })
  .catch((e) => {
    console.error("Startup failed:", e);
    process.exit(1);
  });
