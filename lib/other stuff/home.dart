import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecoeats/other%20stuff/notifiers.dart';
import 'package:ecoeats/other%20stuff/result.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    LocationPermission requestPermission = await Geolocator.requestPermission();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    return await Geolocator.getCurrentPosition();
  }

  final List<String> items = [
    '🇺🇸  English',
    '🇭🇹  Kreyòl ayisyen',
    '🇫🇷  Français',
  ];
  String? selectedValue = "🇺🇸  English";
  TextEditingController controller = TextEditingController();
  bool show = false;
  bool food = false;
  bool job = false;
  bool shelter = false;
  bool health = false;
  bool speaking = false;
  late final location;
  bool isLoading = true;
  hi() async {
    location = await _determinePosition();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    hi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: SizedBox()));
    }
    print(location);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.grey.shade300,

        title: Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text(
            selectedValue == '🇺🇸  English'
                ? 'Welcome Back'
                : selectedValue == '🇭🇹  Kreyòl ayisyen'
                ? 'Byenvini tounen'
                : "Content de te revoir",
            style: GoogleFonts.quicksand(
              fontSize: 35,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 150),
                  Text(
                    selectedValue == '🇺🇸  English'
                        ? 'How can we help you?'
                        : selectedValue == '🇭🇹  Kreyòl ayisyen'
                        ? 'Kijan nou ka ede w jodi a?'
                        : "Comment pouvons-nous vous aider aujourd'hui ?",
                    style: GoogleFonts.quicksand(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    radius: 60,
                    child: IconButton(
                      splashColor: Colors.greenAccent.shade100,
                      onPressed: () {
                        if (!speaking) {
                          Flushbar(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                            backgroundColor: Colors.deepPurple.shade200,
                            margin: EdgeInsets.only(right: 20, left: 20),
                            padding: EdgeInsets.all(12),
                            duration: Duration(seconds: 3),
                            message: "Try to speak a little louder if you can",
                            messageColor: Colors.black,
                            flushbarPosition: FlushbarPosition.TOP,
                            borderRadius: BorderRadius.circular(20),
                            title: "Speak Louder",
                            titleColor: Colors.black,
                            icon: Icon(
                              Icons.campaign,
                              color: Colors.grey.shade700,
                            ),
                          ).show(context);
                        }

                        setState(() {
                          speaking = !speaking;
                        });
                      },
                      icon:
                          speaking
                              ? Lottie.asset(
                                "assets/lotties/speaking.json",
                                width: 200,
                                height: 200,
                              )
                              : Image(
                                image: AssetImage('assets/images/download.png'),
                                width: 110,
                                height: 110,
                              ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Container(
                    height: 80,
                    width: double.infinity,
                    //decoration: BoxDecoration(border: Border.all(width: 3)),
                    child: TextField(
                      controller: controller,
                      expands: true,
                      maxLines: null,
                      style: GoogleFonts.lexend(),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusColor: Colors.blueAccent,
                        hint: Padding(
                          padding: EdgeInsetsGeometry.only(left: 10),
                          child: Text(
                            selectedValue == '🇺🇸  English'
                                ? 'Start Typing...'
                                : selectedValue == '🇭🇹  Kreyòl ayisyen'
                                ? 'Kòmanse ekri...'
                                : "Commencez à taper...",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        maintainHintSize: true,
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: IconButton(
                      onPressed: () async {
                        await sendAPIReq();
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),

                        width: double.infinity,
                        height: 50,
                        child: Center(
                          child: Text(
                            selectedValue == '🇺🇸  English'
                                ? 'Send'
                                : selectedValue == '🇭🇹  Kreyòl ayisyen'
                                ? 'Voye'
                                : "Envoyer",
                            style: GoogleFonts.lexend(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 30,
                left: 120,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Row(
                        children: [
                          Icon(Icons.list, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Select Language',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items:
                          items
                              .map(
                                (String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                              .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: 160,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.black26),
                          color: Colors.blueAccent,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_forward_ios_outlined),
                        iconSize: 14,
                        iconEnabledColor: Colors.white,
                        iconDisabledColor: Colors.blueAccent,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.blueAccent,
                        ),
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all<double>(6),
                          thumbVisibility: MaterialStateProperty.all<bool>(
                            true,
                          ),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //     // border: Border.all(color: Colors.black, width: 2),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.symmetric(horizontal: 4),
              //           child: ElevatedButton(
              //             onPressed: () {
              //               setState(() {
              //                 show = !show;
              //               });
              //             },
              //             style: ElevatedButton.styleFrom(
              //               backgroundColor: Colors.teal,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(30),
              //               ),
              //             ),
              //             child: Text(
              //               '🇺🇸  English',
              //               textAlign: TextAlign.center,
              //               style: GoogleFonts.quicksand(
              //                 color: Colors.red,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //           ),
              //         ),
              //         AnimatedSwitcher(
              //           duration: Duration(milliseconds: 400),
              //           child:
              //               show
              //                   ? Padding(
              //                     padding: EdgeInsets.symmetric(
              //                       horizontal: 4,
              //                     ),
              //                     child: ElevatedButton(
              //                       onPressed: () {},
              //                       style: ElevatedButton.styleFrom(
              //                         backgroundColor: Colors.blueAccent,
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(
              //                             30,
              //                           ),
              //                         ),
              //                       ),
              //                       child: Text(
              //                         '🇫🇷  French',
              //                         textAlign: TextAlign.center,
              //                         style: GoogleFonts.quicksand(
              //                           color: Colors.red,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                   : SizedBox.shrink(),
              //         ),
              //         AnimatedSwitcher(
              //           duration: Duration(milliseconds: 400),
              //           child:
              //               show
              //                   ? Padding(
              //                     padding: EdgeInsets.symmetric(
              //                       horizontal: 4,
              //                     ),
              //                     child: ElevatedButton(
              //                       onPressed: () {},
              //                       style: ElevatedButton.styleFrom(
              //                         backgroundColor: Colors.grey,
              //                         shape: RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.circular(
              //                             30,
              //                           ),
              //                         ),
              //                       ),
              //                       child: Text(
              //                         '🇭🇹  Creole',
              //                         textAlign: TextAlign.center,
              //                         style: GoogleFonts.quicksand(
              //                           color: Colors.red,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                     ),
              //                   )
              //                   : SizedBox.shrink(),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  sendAPIReq() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      52.2165157,
      6.9437819,
    );
    print(placemarks);
    final fetchAPI = await http.post(
      Uri.parse("http://192.168.10.156:3500/"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "message": controller.text.trim(),
        "location": "${location}",
      }),
    );
    final json = await jsonDecode(fetchAPI.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Result(Data: json)),
    );
  }
}
