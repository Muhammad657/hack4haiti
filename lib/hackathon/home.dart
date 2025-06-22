import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/main%20(1).dart';
import 'package:ecoeats/hackathon/onboardingpage.dart';
import 'package:ecoeats/hackathon/resultpage.dart';
import 'package:ecoeats/hackathon/texttospeech.dart';
import 'package:ecoeats/other%20stuff/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class HomeHack extends StatefulWidget {
  const HomeHack({super.key});

  @override
  State<HomeHack> createState() => _HomeHackState();
}

class _HomeHackState extends State<HomeHack> {
  late bool deviceOffline;
  String selectedLang = "English";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        bool isEnglish = true;
        bool isFrench = false;
        bool isCreole = false;
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
          isEnglish = selectedLang == "English";
          isFrench = selectedLang == "French";
          isCreole = selectedLang == "Creole";
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade100, Colors.deepPurple.shade100],
                  ),
                ),
              ),
              toolbarHeight: 100,
              title: ClipOval(
                child: Image.asset(
                  "assets/images/konekte.png",
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),

              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Onboardingpage(),
                        ),
                      );
                    },
                    icon: Row(
                      children: [
                        Text(
                          isEnglish
                              ? "Language"
                              : isCreole
                              ? "Lang"
                              : isFrench
                              ? "Langue"
                              : "Language",
                        ),
                        SizedBox(width: 20.w),
                        Icon(Icons.language),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.deepPurple.shade100],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 70.h),
                  Padding(
                    padding: EdgeInsetsGeometry.only(),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        isEnglish
                            ? "Hello!"
                            : isCreole
                            ? "Bonjou!"
                            : isFrench
                            ? "Bonjour!"
                            : "Hello!",

                        style: GoogleFonts.lexend(
                          fontSize: isFrench ? 20.sp : 20.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 20, right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        isEnglish
                            ? "How can we help you?"
                            : isCreole
                            ? "Kijan nou ka ede w?"
                            : isFrench
                            ? "Comment pouvons-nous vous aider?"
                            : "How can we help you?",

                        style: GoogleFonts.lexend(
                          fontSize: isFrench ? 25.sp : 25.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: isFrench ? 30.h : 20.h),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0, left: 12),
                      child: Container(
                        padding: EdgeInsets.all(12),
                        height: 150,
                        width: 400,
                        decoration: BoxDecoration(),
                        child: Stack(
                          children: [
                            TextField(
                              controller: controller,
                              maxLines: null,
                              expands: true,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                hintText:
                                    isEnglish
                                        ? "I'm in Port-au-Prince and I'm hungry..."
                                        : isCreole
                                        ? "Mwen nan Pòtoprens epi mwen grangou..."
                                        : isFrench
                                        ? "Je suis à Port-au-Prince et j'ai faim..."
                                        : "I'm in Port-au-Prince and I'm hungry...",

                                hintStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 16,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: Color(0xFF295FA0),
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                              ),
                            ),

                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TextToSpeech(),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.mic,
                                  color: Color.fromRGBO(41, 95, 160, 1),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () async {
                                    await getResponse();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: Color.fromRGBO(41, 95, 160, 1),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  getResponse() async {
    print("Sending Request");
    final http.Response request = await http.post(
      Uri.parse("http://192.168.10.152:3500/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": controller.text.trim(),
        "location": "Provided in the message",
      }),
    );
    print("Got Response");
    if (request.statusCode == 200) {
      print("Upload Successful");
    } else {
      print("Upload Failed");
    }
    final jsondecodedrequest = await jsonDecode(request.body);
    final decod = base64Decode(jsondecodedrequest["audio"]);
    final dir = await getApplicationDocumentsDirectory();
    File fileee = File(path.join(dir.path, "response.mp3"));
    fileee.writeAsBytes(decod, flush: true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResultPage(
              filepath: fileee.path,
              response: jsondecodedrequest["response"],
            ),
      ),
    );
    controller.clear();
  }
}
