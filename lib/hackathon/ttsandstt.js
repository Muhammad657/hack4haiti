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
  apiKey: "OPEN_AI_KEY",
});

async function getAudio(input) {
  const mp3 = await openai.audio.speech.create({
    model: "gpt-4o-mini-tts",
    voice: "alloy",
    input: input,
  });

  const buffer = Buffer.from(await mp3.arrayBuffer());
  try {
    fs.writeFileSync("speech.mp3", buffer);
    console.log("Audio Saved");
  } catch (err) {
    console.error(err);
  }
}
const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, "uploads/"),
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const name = path.basename(file.originalname, ext);
    cb(null, `${name}${ext}`);
  },
});

const upload = multer({ storage });

const app = express();
app.use(express.json());
app.post("/", upload.single("audio"), async (req, res) => {
  const filePath = req.file.path;
  const fileData = fs.createReadStream(filePath);
  const formData = new FormData();
  formData.append("model", "whisper-1");
  formData.append("file", fileData, {
    filename: req.file.originalname,
    contentType: req.file.mimetype,
  });
  try {
    const whisperResponse = await axios.post(
      "https://api.openai.com/v1/audio/transcriptions",
      formData,
      {
        headers: {
          ...formData.getHeaders(),
          Authorization:
            "Bearer openaikey",
        },
        maxContentLength: Infinity,
        maxBodyLength: Infinity,
      }
    );
    console.log(await whisperResponse.data.text);
    const request = await fetch("http://192.168.10.156:3500/", {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: whisperResponse.data.text,
        Location: "Should be in the message section",
      }),
    });
    const jsonDecodedRequest = await request.json();
    console.log(jsonDecodedRequest["bottext"]);
    await getAudio(jsonDecodedRequest["bottext"]);
    const audioBuffer = await fsPromises.readFile("speech.mp3");
    const base64Audio = audioBuffer.toString("base64");
    console.log("Got Audio! Sending now...");
    res.json({
      text: jsonDecodedRequest,
      audio: base64Audio,
    });
  } catch (e) {
    console.log("Whisper Erorr. Error: ", e);
  }
});

app.listen(PORT, "0.0.0.0", () => {
  console.log("Express Server Listening on Port " + PORT);
});
