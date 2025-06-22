import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class CommunityChat extends StatefulWidget {
  const CommunityChat({super.key});

  @override
  State<CommunityChat> createState() => _CommunityChatState();
}

class _CommunityChatState extends State<CommunityChat> {
  TextEditingController username = TextEditingController();
  ScrollController scrollController = ScrollController();
  late Box usernameBox;
  bool isLoading = true;
  void initializeStuff() async {
    usernameBox = await Hive.openBox("userName");
    print(usernameBox.get("name"));
    if (usernameBox.get("name") == null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Color.fromRGBO(204, 244, 175, 1)),
              ),
              content: Container(
                height: 206,
                width: 300,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Please Enter Your Name",
                        style: GoogleFonts.lexend(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "This will be visible to others so please make it appropriate",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    TextField(
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        usernameBox.put("name", value.trim());
                        Navigator.pop(context);
                      },
                      cursorColor: Colors.white,
                      controller: username,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        enabled: true,
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                        contentPadding: EdgeInsets.all(4),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(204, 244, 175, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        if (username.text.length == 0) {
                          return;
                        }
                        usernameBox.put("name", username.text.trim());
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(204, 244, 175, 1),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        padding: EdgeInsets.all(12),
                        height: 45,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Continue",
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    initializeStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double contHeight = 45;
    final chatMessage = FirebaseFirestore.instance
        .collection("chats")
        .doc("messages")
        .collection("texts")
        .orderBy("timestamp", descending: false);
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community Chat',
          style: GoogleFonts.lexend(color: Colors.black, letterSpacing: 2),
        ),
        toolbarHeight: 50,
        backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: chatMessage.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  final message = snapshot.data!.docs;
                  if (message.isEmpty) {
                    return Center(
                      child: Text(
                        "No Messages Found",
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: SafeArea(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: message.length,
                            itemBuilder: (context, index) {
                              final currentMessage = message[index];
                              DateTime datetime =
                                  currentMessage["timestamp"].toDate();
                              final formatTime = DateFormat(
                                "h:mm a",
                              ).format(datetime);
                              final isBig =
                                  currentMessage["text"].toString().length >=
                                  30;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  right: 12.0,
                                  left: 12,
                                  bottom: 12,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          currentMessage["user"] ==
                                                  usernameBox.get("name")
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.start,
                                      children: [
                                        currentMessage["user"] !=
                                                usernameBox.get("name")
                                            ? Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          Colors.grey.shade100,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    foregroundColor:
                                                        Colors.grey,
                                                    backgroundColor:
                                                        Colors.grey.shade100,
                                                    child: Icon(Icons.person),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    formatTime,
                                                    style: GoogleFonts.lexend(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                            : SizedBox(),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 20.0,
                                            left: 20,
                                          ),
                                          child: Container(
                                            width:
                                                isBig
                                                    ? MediaQuery.of(
                                                          context,
                                                        ).size.width *
                                                        0.6
                                                    : null,
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color:
                                                  currentMessage["user"] ==
                                                          usernameBox.get(
                                                            "name",
                                                          )
                                                      ? Colors.blue.shade200
                                                      : Colors.white,
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    currentMessage["user"] ==
                                                            usernameBox.get(
                                                              "name",
                                                            )
                                                        ? Radius.zero
                                                        : Radius.circular(12),
                                                bottomLeft:
                                                    currentMessage["user"] !=
                                                            usernameBox.get(
                                                              "name",
                                                            )
                                                        ? Radius.zero
                                                        : Radius.circular(12),
                                                topLeft: Radius.circular(12),
                                                topRight: Radius.circular(12),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  currentMessage["user"] ==
                                                          usernameBox.get(
                                                            "name",
                                                          )
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                              children: [
                                                index != 0
                                                    ? message[index -
                                                                1]["user"] ==
                                                            currentMessage["user"]
                                                        ? SizedBox()
                                                        : Text(
                                                          currentMessage["user"],
                                                          style: GoogleFonts.lexend(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                currentMessage["user"] !=
                                                                        usernameBox.get(
                                                                          "name",
                                                                        )
                                                                    ? Colors
                                                                        .black
                                                                    : Colors
                                                                        .black,
                                                          ),
                                                        )
                                                    : Text(
                                                      currentMessage["user"],
                                                      style: GoogleFonts.lexend(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            currentMessage["user"] !=
                                                                    usernameBox
                                                                        .get(
                                                                          "name",
                                                                        )
                                                                ? Colors.black
                                                                : Colors.black,
                                                      ),
                                                    ),
                                                Text(
                                                  currentMessage["text"],
                                                  style: TextStyle(
                                                    color:
                                                        currentMessage["user"] !=
                                                                usernameBox.get(
                                                                  "name",
                                                                )
                                                            ? Colors.black
                                                            : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            index != 0
                                                ? currentMessage["user"] ==
                                                        usernameBox.get("name")
                                                    ? message[index -
                                                                1]["user"] ==
                                                            usernameBox.get(
                                                              "name",
                                                            )
                                                        ? SizedBox(width: 40)
                                                        : Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                  50,
                                                                ),
                                                            border: Border.all(
                                                              color:
                                                                  Colors
                                                                      .blue
                                                                      .shade100,
                                                            ),
                                                          ),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors
                                                                    .blue
                                                                    .shade100,
                                                            foregroundColor:
                                                                Colors.black,
                                                            child: Icon(
                                                              Icons.person_2,
                                                            ),
                                                          ),
                                                        )
                                                    : SizedBox()
                                                : Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          Colors.blue.shade100,
                                                    ),
                                                  ),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.blue.shade100,
                                                    foregroundColor:
                                                        Colors.black,
                                                    child: Icon(Icons.person_2),
                                                  ),
                                                ),
                                            SizedBox(height: 5),
                                            index != 0
                                                ? currentMessage["user"] ==
                                                        usernameBox.get("name")
                                                    ? message[index -
                                                                1]["user"] ==
                                                            currentMessage["user"]
                                                        ? SizedBox(width: 60)
                                                        : Text(
                                                          formatTime,
                                                          style:
                                                              GoogleFonts.lexend(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                        )
                                                    : SizedBox()
                                                : Text(
                                                  formatTime,
                                                  style: GoogleFonts.lexend(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 20,

                //                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: BoxDecoration(),
                height: contHeight,
                child: TextField(
                  cursorColor: Colors.black,
                  onSubmitted: (value) async {
                    if (username.text.isEmpty) {
                      return;
                    }
                    await FirebaseFirestore.instance
                        .collection("chats")
                        .doc("messages")
                        .collection("texts")
                        .add({
                          "text": username.text.trim(),
                          "timestamp": Timestamp.now(),
                          "user": usernameBox.get("name"),
                        });
                    username.clear();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (scrollController.hasClients) {
                        scrollController.jumpTo(
                          scrollController.position.maxScrollExtent,
                        );
                      }
                    });
                  },

                  textAlignVertical: TextAlignVertical.center,
                  controller: username,
                  style: GoogleFonts.sourceCodePro(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    focusColor: Colors.blue.shade200,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.blue.shade800),
                    ),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    suffixIcon: InkWell(
                      onTap: () async {
                        if (username.text.isEmpty) {
                          return;
                        }
                        await FirebaseFirestore.instance
                            .collection("chats")
                            .doc("messages")
                            .collection("texts")
                            .add({
                              "text": username.text.trim(),
                              "timestamp": Timestamp.now(),
                              "user": usernameBox.get("name"),
                            });
                        username.clear();
                      },
                      child: Icon(Icons.send, color: Colors.blue.shade500),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 15,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
