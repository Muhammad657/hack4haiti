import 'dart:convert';
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:ecoeats/hackathon/resultpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class TextToSpeech extends StatefulWidget {
  const TextToSpeech({super.key});

  @override
  State<TextToSpeech> createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech>
    with SingleTickerProviderStateMixin {
  bool isRecording = false;
  bool shownflushBar = false;
  bool isLoading = true;
  late final AnimationController animationController;
  AudioRecorder audioRecorder = AudioRecorder();
  configureSpeak() async {
    if (await audioRecorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      await audioRecorder.start(
        RecordConfig(),
        path: path.join(dir.path, "userRecordings.m4a"),
      );

      setState(() {
        isLoading = false;
        isRecording = true;
      });
      if (!shownflushBar) {
        Flushbar(
          borderRadius: BorderRadius.circular(16),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(16),
          duration: Duration(seconds: 4),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.orange.shade700,
          titleText: Text(
            "Speak Louder",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          messageText: Text(
            "Please speak loudly and stay close to the microphone for better accuracy.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.95),
            ),
          ),
          icon: Icon(Icons.volume_up_rounded, size: 28, color: Colors.white),
        ).show(context);

        print("showed flushbar now");

        setState(() {
          shownflushBar = true;
        });
      }
    }
  }

  callconfigurespeak() async {
    await configureSpeak();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      configureSpeak();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () async {
                isRecording ? await audioRecorder.stop() : null;
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            backgroundColor: Colors.white,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () async {
                        print("before: ${isRecording}");
                        setState(() {
                          isRecording = !isRecording;
                        });
                        print("after: ${isRecording}");
                        if (!isRecording) {
                          final paaah = await audioRecorder.stop();
                          animationController.stop();
                          await contactWhisper(paaah!);
                        } else {
                          await configureSpeak();
                          animationController.repeat();
                        }
                      },
                      icon: Lottie.asset(
                        repeat: true,
                        controller: animationController,
                        "assets/lotties/sirispeaking.json",

                        onLoaded: (p0) async {
                          animationController.duration = p0.duration;
                          animationController.repeat();
                        },
                        width: 300.w,
                        height: 300.h,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  contactWhisper(String a) async {
    if (a == null || a.isEmpty) return;
    final dir = await getApplicationCacheDirectory();
    File file = File(a);
    http.MultipartRequest request = http.MultipartRequest(
      "POST",
      Uri.parse("http://192.168.10.152:3500/"),
    );
    request.fields["message"] = "Audio Message From User";
    request.fields["location "] = "Port-Au-Prince, Haiti";
    print("Adding Files");
    request.files.add(await http.MultipartFile.fromPath("audio", file.path));
    print("File added to file");
    print("Request Sending");
    final response = await request.send();
    print("Request Send and got response");
    if (response.statusCode == 200) {
      print("Upload Successful");
    } else {
      print("NOt Successful");
    }
    final jsonDecoded = await jsonDecode(await response.stream.bytesToString());

    final audioBytes = base64Decode(jsonDecoded["audio"]);
    print(audioBytes);
    print("streamed finished");
    File file2 = File(path.join(dir.path, "response.mp3"));
    await file2.writeAsBytes(audioBytes, flush: true);
    print("Print finished writing bytes");
    print(jsonDecoded["text"]);
    print("Saved file at: ${file2.path}");
    print("Exists? ${await file.exists()}");
    print("Size: ${await file.length()}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ResultPage(response: jsonDecoded["text"], filepath: file2.path),
      ),
    );
  }
}
