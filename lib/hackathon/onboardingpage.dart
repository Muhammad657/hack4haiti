import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/gnav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboardingpage extends StatefulWidget {
  const Onboardingpage({super.key});

  @override
  State<Onboardingpage> createState() => _OnboardingpageState();
}

class _OnboardingpageState extends State<Onboardingpage> {
  String selectedLang = "";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLang = state.selectedLang;
        }
        return Scaffold(
          backgroundColor: Color.fromRGBO(230, 248, 253, 1),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70.h),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    selectedLang == "English"
                        ? "Selected Language"
                        : selectedLang == "French"
                        ? "Sélectionner la langue"
                        : selectedLang == "Creole"
                        ? "Chwazi lang"
                        : "Selected Language",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp,
                      color: Color.fromRGBO(54, 106, 129, 1),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                  child: Text(
                    selectedLang == "English"
                        ? "Tip: You can change this later in Settings"
                        : selectedLang == "French"
                        ? "Astuce : vous pouvez modifier cela ultérieurement dans les paramètres"
                        : selectedLang == "Creole"
                        ? "Konsèy: Ou ka chanje sa pita nan Anviwònman yo"
                        : "Tip: You can change this later in Settings",
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      color: Color.fromRGBO(54, 106, 129, 1),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                ((selectedLang == "English") || (selectedLang == ""))
                    ? SizedBox(height: 75.h)
                    : SizedBox(height: 50.h),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 30,
                    left: 30,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => BlocProvider.of<LanguageBloc>(
                          context,
                        ).add(SelectLangEvent(selectedLang: "English")),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              selectedLang == "English"
                                  ? Colors.green.shade500
                                  : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/usa.png",

                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 70.w),
                          Text(
                            "English",
                            style: GoogleFonts.lexend(
                              fontWeight:
                                  selectedLang == "English"
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 30,
                    left: 30,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<LanguageBloc>(
                        context,
                      ).add(SelectLangEvent(selectedLang: "Creole"));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              selectedLang == "Creole"
                                  ? Colors.green.shade500
                                  : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/haiti.png",

                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 70.w),
                          Text(
                            "Kreyòl ayisyen",
                            style: GoogleFonts.lexend(
                              fontWeight:
                                  selectedLang == "Creole"
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    right: 30,
                    left: 30,
                  ),
                  child: GestureDetector(
                    onTap:
                        () => BlocProvider.of<LanguageBloc>(
                          context,
                        ).add(SelectLangEvent(selectedLang: "French")),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              selectedLang == "French"
                                  ? Colors.green.shade500
                                  : Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              "assets/images/france.png",

                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 70.w),
                          Text(
                            "Français",
                            style: GoogleFonts.lexend(
                              fontWeight:
                                  selectedLang == "French"
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, right: 50, left: 50),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: IconButton(
                      onPressed: () {
                        if (selectedLang == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                children: [
                                  Icon(Icons.error),
                                  SizedBox(width: 40.w),
                                  Text(
                                    "Please Select a Language",
                                    style: GoogleFonts.sourceCodePro(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          return;
                        }
                        BlocProvider.of<LanguageBloc>(
                          context,
                        ).add(SelectLangEvent(selectedLang: selectedLang));
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => NavBarr()),
                        );
                      },
                      icon: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedLang == "English"
                              ? "Continue"
                              : selectedLang == "French"
                              ? "Continuer"
                              : selectedLang == "Creole"
                              ? "Kontinye"
                              : "Continue",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
