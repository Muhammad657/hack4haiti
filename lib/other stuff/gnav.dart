import 'package:ecoeats/chat/chat.dart';
import 'package:ecoeats/e-waste%20app/chatforewaste.dart';
import 'package:ecoeats/chat/chatlight.dart';
import 'package:ecoeats/other%20stuff/home.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Gnav extends StatefulWidget {
  const Gnav({super.key});

  @override
  State<Gnav> createState() => _GnavState();
}

class _GnavState extends State<Gnav> {
  List<Widget> items = [Home(), ChatPageForUsers()];
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        backgroundColor: Colors.grey.shade200,
        tabMargin: EdgeInsetsGeometry.only(bottom: 30),
        activeColor: Colors.black,
        padding: EdgeInsetsGeometry.symmetric(horizontal: 40, vertical: 15),
        color: Colors.grey,
        tabBorderRadius: 50,
        tabBackgroundColor: Colors.teal,
        mainAxisAlignment: MainAxisAlignment.center,
        onTabChange: (value) {
          setState(() {
            selectedValue = value;
          });
        },
        tabs: [GButton(icon: Icons.home), GButton(icon: Icons.chat)],
      ),
      body: items[selectedValue],
    );
  }
}
