const express = require("express");

const path = require("path");

const app = express();

const port = process.env.PORT || 8080;


app.use("/wiki", express.static(path.join(__dirname, "wiki")));

app.get("/", (req, res) => {
  res.send("Hello!");
});

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.listen(port, "0.0.0.0", () => {
  
  console.log(`Example app listening on port ${port}`);
});


