import 'dart:convert';

import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/main%20(1).dart';
import 'package:ecoeats/hackathon/onboardingoflinepage.dart';
import 'package:ecoeats/hackathon/onboardingpage.dart';
import 'package:ecoeats/hackathon/resultpage.dart';
import 'package:ecoeats/hackathon/texttospeech.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeOfflineHack extends StatefulWidget {
  const HomeOfflineHack({super.key});

  @override
  State<HomeOfflineHack> createState() => _HomeOfflineHackState();
}

class _HomeOfflineHackState extends State<HomeOfflineHack> {
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
                          builder: (context) => OnboardingOfflinePage(),
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
                    padding: EdgeInsetsGeometry.only(bottom: 20),
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
                            ? "Take the offline help survey to find out the best available help you can find for your problem!"
                            : isCreole
                            ? "Patisipe nan sondaj èd offline la pou w ka jwenn pi bon èd ki disponib pou pwoblèm ou an!"
                            : isFrench
                            ? "Répondez à l’enquête d’aide hors ligne pour découvrir la meilleure aide disponible que vous pouvez trouver pour votre problème!"
                            : "Take the offline help survey to find out the best available help you can find for your problem!",

                        style: GoogleFonts.lexend(
                          fontSize: isFrench ? 25.sp : 25.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: isFrench ? 50.h : 50.h),
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
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 12,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WelcomeOffline(),
                                    ),
                                  );
                                },
                                icon: Container(
                                  width: double.infinity,
                                  height: 50,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.shade200,
                                        Colors.blue.shade900,
                                        Colors.blue.shade200,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isEnglish
                                          ? "Take the Survey!"
                                          : isCreole
                                          ? "Pran Sondaj la!"
                                          : isFrench
                                          ? "Participez à l'enquête!"
                                          : "Take the Survey!",
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
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
    final http.Response request = await http.post(
      Uri.parse("http://192.168.10.156:3500/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "message": controller.text.trim(),
        "location": "Provided in the message",
      }),
    );
    final jsondecodedrequest = await jsonDecode(request.body);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(response: jsondecodedrequest),
      ),
    );
    controller.clear();
  }
}
