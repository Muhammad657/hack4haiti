const os = require("os");
const networkInterfaces = os.networkInterfaces();
const express = require("express");
const server = express();
const PORT = 3500;
const myApiKey = "OPEN_AI_KEY";

for (const name of Object.keys(networkInterfaces)) {
  for (const net of networkInterfaces[name]) {
    if (net.family === "IPv4" && !net.internal) {
      console.log(`Lan IP address: ${net.address}`);
    }
  }
}

server.use(express.json());
server.post("/", async (req, res) => {
  console.log(req.body.message);
  const myRes = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${myApiKey}`,
      Accept: "application/json",
    },
    body: JSON.stringify({
      model: "gpt-4o",
      messages: [
        {
          role: "user",
          content: `${req.body.message}. This is what the user entered. Here is also the user's location:${req.body.location}\nPlease form one or two statments or questions, that can be entered onto google search to provide the appropriate information that will really help the user in haiti. Remeber to give your response in english(convert the user's response to english) and also remember to phrase your response such that we get urls for maps and directions of places if needed(use the locaion). Remember to as well phrase your response such that the info recieved from the google search provides a breif discripton of places if needed. Your response will be the response that will be directly entered onto google serach so only give the statment(s) in your response, nothing else.`,
        },
      ],
      temperature: 0.7,
    }),
  });
  const myApiRes = await myRes.json();
  console.log(myApiRes);
  const apiRes =
    myApiRes.choices?.[0]?.message?.content || "No response from API";
  console.log(apiRes);
  const myQuery = encodeURIComponent(`${apiRes}`);
  const mapUrls = `https://www.google.com/maps/search/?api=1&query=${myQuery}`;
  console.log(mapUrls);
  const googSearch = await fetch(
    `https://www.googleapis.com/customsearch/v1?key=AIzaSyA_EluQSkuYu3N5Kh-1pWbcHiPcQ3hSRh0&cx=32b6138aa107f495c&q=${apiRes}`
  );
  const myData = await googSearch.json();
  console.log(myData);
  const myRealInfo = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${myApiKey}`,
      Accept: "application/json",
    },
    body: JSON.stringify({
      model: "gpt-4o",
      messages: [
        {
          content: `${req.body.message}. This is what the user entered.\nHere is also the user's location: ${req.body.location}.\n Here are a few urls of places that correspond with what the user entered: ${mapUrls}\nThis is the information recived from google search: ${myData}.\n Please organize the data and only provide the accurate infromation that will help the user in Haiti. Remember to proivide a list of places (between 3-5) and a small discription about each. Remember as well to include atleast one URL, when clicked gives a bunch of places(exp: restaurants, hospitals or shelter houses). Only user URL's if they are provided and don't guess or make up URLs. Reply in the same language as the user entered in. If the user entered in english reply in english. If the the user entered in french, reply in french. If the user entered in creole, reply in creole.  Again, only use accurate and verified place names. You should also include a main title for the whole response, such as Food Places, Hospitals, Shelter houses or anything else. You sould also give a text that wisper AI can read, this text will be read by the Whisper Ai when the results are displayed o the user in the app, make sure this is in the same language as the user's prompt's language. You should also enter the location of where each place is. You must provide the information as a key value pair in a form of an object. Use this example as the format:\n object: {title: "Food Places", places: [{placeName: "Enter the full name of the place", description: "Enter a breife( one or two sentences) description of the place", location: "enter the location of where the place is."}], url: "One URL, when clicked provides a list of places(food Places, hospitals, shelter cares, or etc.), bottext: the text read by the WHisper Ai to the user.Make this as detailed as possible so even a blind user can understand it based on the hearing.}\nThe name of the object must be object, all lower case. And always keep the array by name "place" inside of the object, by name "object", the same name don't change it each time as place1, place2. And include all the 3-5 placeName and description inside of the the array by name places, but make them seperate objects in side of the array.\nOnly send the object by name objcet, nothing extra.(don't send a string before or after the object. You must only send the object only.) Your response should solely be in application/json format\nOnly respond with a valid JSON object. Do not include any explanation, apology, or extra text. Do not use code blocks. Only output the JSON object. You must only respond with a valid JSON object, starting directly with {. Do not add labels like object:, and do not use \`\`\`json markdown. No explanation or extra text.`,
          role: "user",
        },
      ],
      temperature: 0.7,
    }),
  });
  const realInfos = await myRealInfo.json();
  console.log(realInfos);
  const realInfo =
    (await realInfos.choices?.[0]?.message?.content) || "No response from API";
  console.log(realInfo);

  try {
    const match = realInfo.match(/{[\s\S]*}/);
    if (!match) throw new Error("No valid JSON object found in AI response.");
    let jsonStr = match[0];

    const parsed = JSON.parse(jsonStr);

    const realData = parsed.object ? parsed.object : parsed;

    if (!Array.isArray(realData.places)) {
      throw new Error("Missing or invalid 'places' array in object.");
    }

    realData.places = realData.places.map((place) => ({
      ...place,
      myUrl: `https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(
        `${place.placeName} in ${place.location}`
      )}`,
    }));
    console.log(realData);

    res.json(realData);
  } catch (e) {
    console.error("Couldn't parse the object", e);
    res.status(500).send("Error parsing response: " + e.message);
    console.log("POST Requested");
  }
});

server.listen(PORT, () => {
  console.log(`server is running on port ${PORT}`);
});
