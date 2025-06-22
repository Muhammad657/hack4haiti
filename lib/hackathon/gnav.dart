import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/chat.dart';
import 'package:ecoeats/hackathon/home.dart';
import 'package:ecoeats/other%20stuff/gnav.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarr extends StatefulWidget {
  const NavBarr({super.key});

  @override
  State<NavBarr> createState() => _NavBarrState();
}

class _NavBarrState extends State<NavBarr> {
  int selectedIndex = 0;
  List<Widget> pages = [HomeHack(), ChatHack()];
  String selectedLanguage = "";
  bool isEnglish = true;
  bool isFrench = false;
  bool isCreole = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        if (state is SelectedLanguageState) {
          selectedLanguage = state.selectedLang;
          isEnglish = selectedLanguage == "English";
          isFrench = selectedLanguage == "French";
          isCreole = selectedLanguage == "Creole";
        }
        return Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              gradient:
                  selectedIndex == 0
                      ? LinearGradient(
                        colors: [
                          Colors.blue.shade100,
                          Colors.deepPurple.shade100,
                        ],
                      )
                      : LinearGradient(
                        colors: [
                          Colors.blue.shade100,
                          Colors.deepPurple.shade100,
                        ],
                      ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ), // Adds vertical space
              child: GNav(
                mainAxisAlignment: MainAxisAlignment.center,
                gap: 8,
                activeColor: Colors.white,
                color: Color.fromRGBO(21, 56, 223, 1),
                tabBackgroundColor: Color.fromRGBO(21, 56, 223, 1),
                tabBorderRadius: 100,
                padding: const EdgeInsetsGeometry.all(12),
                tabs: const [
                  GButton(icon: Icons.home_outlined),
                  GButton(icon: CupertinoIcons.chat_bubble),
                ],

                //     // text:
                //     //     isEnglish
                //     //         ? "\t\tHome"
                //     //         : isCreole
                //     //         ? "\t\tLakay"
                //     //         : isFrench
                //     //         ? "\t\tMaison"
                //     //         : "\t\tHome",
                //   ),
                //   GButton(
                //     icon: CupertinoIcons.chat_bubble_fill,
                //     // text:
                //     //     isEnglish
                //     //         ? "\t\tChat"
                //     //         : isCreole
                //     //         ? "\t\tChat"
                //     //         : isFrench
                //     //         ? "\t\tChat"
                //     //         : "\t\tChat",
                //   ),
                // ],
                onTabChange: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
          ),
          body: pages[selectedIndex],
        );
      },
    );
  }
}
