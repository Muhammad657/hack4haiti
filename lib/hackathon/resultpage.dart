import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, this.filepath, required this.response});
  final String? filepath;
  final Map response;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  AudioPlayer player = AudioPlayer();

  bool isLoading = true;
  @override
  void initState() {
    super.initState(); // ALWAYS call super first!
    runAudio();
  }

  Future<void> runAudio() async {
    try {
      setState(() {
        isLoading = false;
      });
      await player.play(DeviceFileSource(widget.filepath!));
    } catch (e) {
      print('Audio playback error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () async {
                        await player.stop();
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    widget.response["title"],
                    style: GoogleFonts.montserrat(
                      fontSize: 27.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.response["places"].length,
                    itemBuilder: (context, index) {
                      final cr = widget.response["places"][index];
                      print(cr["location"]);
                      List parts =
                          (cr['location'])
                              .split(",")
                              .map((e) => e.trim())
                              .toList();
                      String result = parts.join("\n");

                      Text(result);
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              height: 310.h,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      cr["placeName"],
                                      style: GoogleFonts.lexend(
                                        fontSize: 20.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      right: 12.0,
                                      left: 12,
                                      bottom: 12,
                                    ),
                                    child: Text(cr["description"]),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.only(
                                            left: 20,
                                            bottom: 8,
                                          ),
                                          child: Wrap(
                                            spacing: 4,
                                            children: [
                                              Text(
                                                '${parts.join("\n")}',
                                                style: GoogleFonts.lexend(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 12.0,
                                            bottom: 12,
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              if (!await launchUrl(
                                                Uri.parse(cr["myUrl"]),
                                              )) {
                                                throw Exception(
                                                  "Url Couldnt be opeepnd",
                                                );
                                              }
                                              ;
                                            },
                                            icon: Container(
                                              width: 100.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.amber.shade400,
                                                // Color.fromRGBO(222, 183, 67, 1),
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: Center(
                                                child: Text(
                                                  "Go!",
                                                  style:
                                                      GoogleFonts.sourceCodePro(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            index == widget.response["places"].length - 1
                                ? Column(
                                  children: [
                                    SizedBox(height: 40),
                                    Text(
                                      "Couldn't find anything suitable? ",
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    IconButton(
                                      onPressed: () async {
                                        if (!await launchUrl(
                                          Uri.parse(widget.response["url"]),
                                        )) {
                                          throw Exception("Couldnt be opened");
                                        }
                                        ;
                                      },
                                      icon: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Color(0xFFCAC0B8),
                                        ),
                                        child: Text(
                                          "Look here for more places!",
                                          style: GoogleFonts.lexend(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : SizedBox.shrink(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
