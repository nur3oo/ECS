const express = require("express");
const path = require("path");
const crypto = require("crypto");

const { S3Client, PutObjectCommand } = require("@aws-sdk/client-s3");
const { getSignedUrl } = require("@aws-sdk/s3-request-presigner");

const app = express();
const port = process.env.PORT || 8080;

// Needed so we can read JSON body from the browser
app.use(express.json({ limit: "1mb" }));


const BUCKET = process.env.DOCS_BUCKET;                 
const REGION = process.env.AWS_REGION || "eu-west-2";
const UPLOADS_PREFIX = process.env.UPLOADS_PREFIX || "uploads/";
const MAX_BYTES = Number(process.env.MAX_UPLOAD_BYTES || 25 * 1024 * 1024); 

if (!BUCKET) {
  console.warn("WARNING: DOCS_BUCKET env var is not set. /api/uploads/presign will fail.");
}

const s3 = new S3Client({ region: REGION });

// Simple sanitizers
function safeFolder(input = "") {
  return input
    .trim()
    .replace(/^\/+|\/+$/g, "")
    .replace(/(\.\.)+/g, "")
    .replace(/[^a-zA-Z0-9/_-]/g, "");
}

function safeFilename(name = "file") {
  const cleaned = String(name).replace(/[^a-zA-Z0-9._-]/g, "_");
  return cleaned.slice(0, 120) || "file";
}

// Redirect /wiki -> /wiki/
app.get("/wiki", (req, res) => res.redirect(301, "/wiki/"));

// Serve static files at /wiki/*
app.use("/wiki", express.static(path.join(__dirname, "wiki"), { index: "index.html" }));

app.get("/health", (req, res) => res.json({ status: "ok" }));

app.get("/", (req, res) => res.redirect("/wiki/"));



/**
 * POST /api/uploads/presign
 * Body: { filename, contentType, size, folder }
 * Returns: { uploadUrl, key }
 */
app.post("/api/uploads/presign", async (req, res) => {
  try {
    
    const { filename, contentType, size, folder } = req.body || {};

    if (!BUCKET) return res.status(500).send("Server missing DOCS_BUCKET env var");
    if (!filename || typeof size !== "number") return res.status(400).send("filename and size required");
    if (size > MAX_BYTES) return res.status(413).send("file too large");

    const folderSafe = safeFolder(folder || "general");
    const fileSafe = safeFilename(filename);
    const id = crypto.randomUUID();

    const key = `${UPLOADS_PREFIX}${folderSafe ? folderSafe + "/" : ""}${id}-${fileSafe}`;
    const ct = contentType || "application/octet-stream";

    const cmd = new PutObjectCommand({
      Bucket: BUCKET,
      Key: key,
      ContentType: ct
    });

    const uploadUrl = await getSignedUrl(s3, cmd, { expiresIn: 60 }); 
    res.json({ uploadUrl, key });
  } catch (err) {
    console.error(err);
    res.status(500).send("failed to create presigned url");
  }
});

app.listen(port, "0.0.0.0", () => {
  console.log(`Example app listening on port ${port}`);
});
