// import 'dart:convert';

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:record/record.dart';
// import 'package:path/path.dart' as path;
// import 'package:lottie/lottie.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class TestingServer extends StatefulWidget {
//   const TestingServer({super.key});

//   @override
//   State<TestingServer> createState() => _TestingServerState();
// }

// class _TestingServerState extends State<TestingServer> {
//   var convertedInfo = [];
//   final AudioRecorder audioRecorder = AudioRecorder();
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool isRecording = false;
//   String? recordedFile;
//   bool isPlaying = false;
//   late stt.SpeechToText speech;
//   String transcribedText = '';
//   bool isListening = false;

//   @override
//   void initState() {
//     super.initState();
//     speech = stt.SpeechToText();
//   }

//   Future<void> startListening() async {
//     // var locales = await speech.locales();
//     // for (int i = 0; i < locales.length; i++) {
//     //   print(locales[i].localeId);
//     // }

//     bool available = await speech.initialize(
//       onStatus: (status) => print(status),
//       onError: (errorNotification) => print(errorNotification),
//     );
//     if (available) {
//       final directory = await getApplicationDocumentsDirectory();
//       final dir = Directory(directory.path);
//       final files = dir.listSync();
//       // File file = File(path.join(directory.path, "userRecordings.m4a"));
//       // final recording = file.readAsBytes();
//       print(files.length);
//       FlutterTts flutterTts = new FlutterTts();
//       //print(await flutterTts.getLanguages);
//       setState(() => isListening = true);
//       speech.listen(
//         localeId: 'ht_HT',
//         onResult: (result) {
//           setState(() {
//             transcribedText = result.recognizedWords;
//           });
//           print(transcribedText);
//         },
//       );
//     }
//   }

//   Future<void> stopListening() async {
//     dynamic dir = await getApplicationDocumentsDirectory();
//     await speech.stop();
//     File file = File(path.join(dir.path, "userRecordings.m4a"));
//     dynamic fileContent = await file.readAsBytes();
//     http.MultipartRequest request = await http.MultipartRequest(
//       "POST",
//       Uri.parse("http://192.168.10.152:3500/"),
//     );
//     request.fields["message"] = "Audio From the User";
//     request.fields["location"] = "Haiti";
//     request.files.add(await http.MultipartFile.fromPath("audio", file.path));
//     final response = await request.send();
//     response.statusCode == 200
//         ? print("Upload Successful")
//         : print("NOt SuccessFul");
//     setState(() => isListening = false);
//   }

//   Future<void> checkFile() async {
//     if (recordedFile == null) return;
//     final file = File(recordedFile!);
//     if (await file.exists()) {
//       final length = await file.length();
//       print("Recording file size: $length bytes");
//       if (length == 0) {
//         print("Warning: file is empty!");
//       }
//     } else {
//       print("File doesn't exist");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           http.Response rawInfo = await http.post(
//             Uri.parse("http://192.168.10.152:3500"),
//             headers: {
//               "method": "GET",
//               "Content-Type": "application/json",
//               "Accept": "application/json",
//             },
//             body: jsonEncode({
//               "message": "Hi. Im hungry",
//               "location": "Haiti, Port-Au-Prince",
//             }),
//           );
//         },
//         child: Icon(Icons.highlight_alt_sharp),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ElevatedButton(
//             onPressed: () async {
//               try {
//                 if (recordedFile != null) {
//                   print("Recording isn't null. ");
//                   if (isPlaying) {
//                     await audioPlayer.stop();
//                     isPlaying = false;
//                     print("audioPlayer stopped");
//                   } else if (!isPlaying) {
//                     await audioPlayer.setFilePath(recordedFile!);
//                     await audioPlayer.play();
//                     setState(() {
//                       isPlaying = true;
//                     });
//                     print("Recording is playing. ");
//                   }
//                 }
//               } catch (e) {
//                 print(e);
//               }
//             },
//             child: isPlaying ? Icon(Icons.stop) : Icon(Icons.play_arrow),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               if (!isRecording) {
//                 if (await audioRecorder.hasPermission()) {
//                   final direc = await getApplicationDocumentsDirectory();
//                   print(direc);
//                   final String pathSave = path.join(
//                     direc.path,
//                     "userRecordings.m4a",
//                   );
//                   await audioRecorder.start(
//                     RecordConfig(
//                       encoder: AudioEncoder.aacLc, // supported by iOS
//                       bitRate: 128000,
//                       sampleRate: 44100,
//                     ),
//                     path: pathSave,
//                   );
//                   print("Recording started");
//                   startListening();
//                   setState(() {
//                     isRecording = true;
//                     recordedFile = null;
//                   });
//                 }
//               } else if (isRecording) {
//                 stopListening();
//                 String? filePath = await audioRecorder.stop();
//                 print("Recording stopped");

//                 setState(() {
//                   isRecording = false;
//                   recordedFile = filePath;
//                 });
//               }
//             },
//             child: isRecording ? Icon(Icons.stop) : Icon(Icons.mic),
//           ),
//           Center(
//             child: Text("${convertedInfo}", style: TextStyle(fontSize: 5)),
//           ),
//           isRecording
//               ? Lottie.asset(
//                 'assets/lotties/recordings.json',
//                 width: 100,
//                 height: 100,
//               )
//               : SizedBox.shrink(),
//         ],
//       ),
//     );
//   }
// }
