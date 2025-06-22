const multer = require("multer");
const express = require("express");
const fs = require("fs");
const path = require("path");
const fsPromises = require("fs").promises;
const FormData = require("form-data");
const dateTime = require("date-fns");
const PORT = 3500;
const axios = require("axios");
const { OpenAI } = require("openai");
const { he } = require("date-fns/locale");

const openai = new OpenAI({
  apiKey: "Open_AI_KEY",
});

async function getAudio(input) {
  const mp3 = await openai.audio.speech.create({
    model: "gpt-4o-mini-tts",
    voice: "alloy",
    input: input,
  });
  const buffer = await Buffer.from(await mp3.arrayBuffer());
  try {
    fs.writeFileSync("speech.mp3", buffer);
    console.log("Audio Saved");
  } catch (err) {
    console.error(err);
  }
}

const app = express();
app.use(express.json());
app.post("/", async (req, res) => {
  console.log("Post Requested");
  const request = await fetch("http://192.168.10.156:3500/", {
    method: "POST",
    headers: {
      Accept: "application/json",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      message: req.body.message,
      location: req.body.location,
    }),
  });
  const jsonDecodedRequest = await request.json();
  await getAudio(jsonDecodedRequest.bottext);
  const some = await fsPromises.readFile("speech.mp3");
  const toBase64 = some.toString("base64");
  res.status(200).json({
    response: jsonDecodedRequest,
    audio: toBase64,
  });
});

app.listen(PORT, () => {
  console.log("Express LIstening");
});
