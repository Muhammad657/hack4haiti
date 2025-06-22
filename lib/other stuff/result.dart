import 'package:flutter/material.dart';
import 'package:ecoeats/other%20stuff/notifiers.dart';

class Result extends StatefulWidget {
  const Result({super.key, required this.Data});
  final Map Data;
  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [if (emergency.value == 1) foodHelpCard()],
          ),
        ),
      ),
    );
  }
}

Widget foodHelpCard() {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Colors.black, width: 2),
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: const SizedBox(
      width: 350,
      height: 250,
      child: Center(
        child: Text(
          'The food places nearby are: \nMcdonalds(fat ass) \nTaco Bell(say bye to bathroom) \nChoinese restaurant(you will be eating bats) \nsigma boy \nnot very sigma \nskibi boy',
        ),
      ),
    ),
  );
}
