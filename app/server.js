const express = require("express");
const app = express();

const port = 80;

app.get("/", (req, res) => {
  res.send("Hello!");
});

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.listen(port, "0.0.0.0", () => {
  console.log(`Example app listening on port ${port}`);
});
