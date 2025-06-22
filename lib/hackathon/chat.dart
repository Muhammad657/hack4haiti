import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

class ChatHack extends StatefulWidget {
  const ChatHack({super.key});

  @override
  State<ChatHack> createState() => _ChatHackState();
}

class _ChatHackState extends State<ChatHack> {
  TextEditingController username = TextEditingController();
  TextEditingController message = TextEditingController();
  ScrollController scrollController = ScrollController();
  late Box usernameBox;
  bool isLoading = true;
  String selectedLanguage = "";
  void initializeStuff() async {
    usernameBox = await Hive.openBox("userName");
    print(usernameBox.get("name"));
    await usernameBox.delete("name");
    if (usernameBox.get("name") == null) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: Color(0xFFC2CAE8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              content: SizedBox(
                height: 260.h,
                width: 300.w,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Please Enter Your Name",
                        style: GoogleFonts.lexend(
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "This will be visible to others so please make it appropriate",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.sourceCodePro(
                        color: Colors.black,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    TextField(
                      onSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        usernameBox.put("name", value.trim());
                        Navigator.pop(context);
                      },
                      cursorColor: Colors.black,
                      controller: username,
                      style: TextStyle(color: Colors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                        fillColor: Colors.white,

                        filled: true,
                        hintText: "Enter Name",
                        enabled: true,
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 15.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.7,
                            color: Colors.blue.shade200,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    IconButton(
                      onPressed: () {
                        if (username.text.length == 0) {
                          return;
                        }
                        usernameBox.put("name", username.text.trim());
                        Navigator.pop(context);
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(12.r),
                        ),

                        height: 45.h,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Continue",
                            style: GoogleFonts.sourceCodePro(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
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
    double contHeight = 45.h;
    final chatMessage = FirebaseFirestore.instance
        .collection("chats")
        .doc("messages")
        .collection("texts")
        .orderBy("timestamp", descending: false);
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        bool isEnglish = true;
        bool isFrench = false;
        bool isCreole = false;
        if (state is SelectedLanguageState) {
          selectedLanguage = state.selectedLang;
          isEnglish = selectedLanguage == "English";
          isFrench = selectedLanguage == "French";
          isCreole = selectedLanguage == "Creole";
        }
        return Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade100, Colors.deepPurple.shade100],
                ),
              ),
            ),
            title: Text(
              isEnglish
                  ? 'Community Chat'
                  : isFrench
                  ? "Discussion communautaire"
                  : isCreole
                  ? "Chat kominotè"
                  : "Community Chat",
              style: GoogleFonts.lexend(color: Colors.black, letterSpacing: 2),
            ),
            toolbarHeight: 100.h,
          ),
          body: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade100, Colors.deepPurple.shade100],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 20.h),
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
                              isEnglish
                                  ? 'Start Chatting!'
                                  : isFrench
                                  ? "Commencez à discuter!"
                                  : isCreole
                                  ? "Kòmanse koze!"
                                  : "Start Chatting!",
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
                                        currentMessage["text"]
                                            .toString()
                                            .length >=
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
                                              if (currentMessage["user"] !=
                                                  usernameBox.get("name")) ...[
                                                if (index == 0 ||
                                                    message[index -
                                                            1]["user"] !=
                                                        currentMessage["user"])
                                                  Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                50.r,
                                                              ),
                                                          border: Border.all(
                                                            color:
                                                                Colors
                                                                    .grey
                                                                    .shade100,
                                                          ),
                                                        ),
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.grey,
                                                          backgroundColor:
                                                              Colors
                                                                  .grey
                                                                  .shade100,
                                                          child: Icon(
                                                            Icons.person,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Align(
                                                        alignment:
                                                            Alignment
                                                                .bottomCenter,
                                                        child: Text(
                                                          formatTime,
                                                          style:
                                                              GoogleFonts.lexend(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  SizedBox(
                                                    width: 60.w,
                                                  ), // Maintain spacing when avatar is hidden
                                              ],

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
                                                            ? Colors
                                                                .blue
                                                                .shade200
                                                            : Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                          currentMessage["user"] ==
                                                                  usernameBox
                                                                      .get(
                                                                        "name",
                                                                      )
                                                              ? Radius.zero
                                                              : Radius.circular(
                                                                12.r,
                                                              ),
                                                      bottomLeft:
                                                          currentMessage["user"] !=
                                                                  usernameBox
                                                                      .get(
                                                                        "name",
                                                                      )
                                                              ? Radius.zero
                                                              : Radius.circular(
                                                                12.r,
                                                              ),
                                                      topLeft: Radius.circular(
                                                        12.r,
                                                      ),
                                                      topRight: Radius.circular(
                                                        12.r,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        currentMessage["user"] ==
                                                                usernameBox.get(
                                                                  "name",
                                                                )
                                                            ? CrossAxisAlignment
                                                                .start
                                                            : CrossAxisAlignment
                                                                .end,
                                                    children: [
                                                      index != 0
                                                          ? message[index -
                                                                      1]["user"] ==
                                                                  currentMessage["user"]
                                                              ? SizedBox()
                                                              : Text(
                                                                currentMessage["user"],
                                                                style: GoogleFonts.lexend(
                                                                  fontSize:
                                                                      10.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                                                          ),
                                                      Text(
                                                        currentMessage["text"],
                                                        style: TextStyle(
                                                          color:
                                                              currentMessage["user"] !=
                                                                      usernameBox
                                                                          .get(
                                                                            "name",
                                                                          )
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              if (currentMessage["user"] ==
                                                  usernameBox.get("name")) ...[
                                                if (index == 0 ||
                                                    message[index -
                                                            1]["user"] !=
                                                        currentMessage["user"])
                                                  Column(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                50.r,
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
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        formatTime,
                                                        style:
                                                            GoogleFonts.lexend(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                      ),
                                                    ],
                                                  )
                                                else
                                                  SizedBox(
                                                    width: 60.w,
                                                  ), // Maintain spacing when avatar is hidden
                                              ],
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,

                          //                bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Container(
                          decoration: BoxDecoration(),
                          height: contHeight,
                          child: TextField(
                            cursorColor: Colors.black,
                            onSubmitted: (value) async {
                              if (message.text.isEmpty) {
                                return;
                              }
                              await FirebaseFirestore.instance
                                  .collection("chats")
                                  .doc("messages")
                                  .collection("texts")
                                  .add({
                                    "text": message.text.trim(),
                                    "timestamp": Timestamp.now(),
                                    "user": usernameBox.get("name"),
                                  });
                              message.clear();
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (scrollController.hasClients) {
                                  scrollController.jumpTo(
                                    scrollController.position.maxScrollExtent,
                                  );
                                }
                              });
                            },

                            textAlignVertical: TextAlignVertical.center,
                            controller: message,
                            style: GoogleFonts.sourceCodePro(
                              fontSize: 15.sp,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              focusColor: Colors.blue.shade200,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(
                                  width: 2.4,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                              enabled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffixIcon: InkWell(
                                onTap: () async {
                                  if (message.text.isEmpty) {
                                    return;
                                  }
                                  await FirebaseFirestore.instance
                                      .collection("chats")
                                      .doc("messages")
                                      .collection("texts")
                                      .add({
                                        "text": message.text.trim(),
                                        "timestamp": Timestamp.now(),
                                        "user": usernameBox.get("name"),
                                      });
                                  message.clear();
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    if (scrollController.hasClients) {
                                      scrollController.jumpTo(
                                        scrollController
                                            .position
                                            .maxScrollExtent,
                                      );
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.send,
                                  color: Colors.blue.shade500,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 15,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
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
