import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoeats/bloc/show_menu_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class ChatPageForUsers extends StatefulWidget {
  const ChatPageForUsers({super.key});

  @override
  State<ChatPageForUsers> createState() => _ChatPageForUsersState();
}

class _ChatPageForUsersState extends State<ChatPageForUsers> {
  TextEditingController controller = TextEditingController();
  bool showInfo = false;
  bool isloading = true;
  runthis() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: "muhammadtaqiulla@gmail.com",
      password: "Taqi0411;!",
    );
    setState(() {
      isloading = false;
    });
  }

  runthisthis() async {
    await runthis();
  }

  @override
  void initState() {
    runthis();

    super.initState();
  }

  sendMsg(String message) async {
    if (message.isEmpty) {
      return;
    }
    await FirebaseFirestore.instance
        .collection("chats")
        .doc("messages")
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .add({"text": message, "timestamp": Timestamp.now(), "user": "user"});

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
          backgroundColor: Color(0XFFDBDBDB),
          appBar: AppBar(
            title: Text(
              "Chat With Us!",
              style: GoogleFonts.fredoka(
                color: Color(0XFFc18c71),
                fontWeight: FontWeight.bold,
                fontSize: 35.sp,
              ),
            ),
            toolbarHeight: 120.h,
            backgroundColor: Color(0XFFDBDBDB),
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance
                        .collection("chats")
                        .doc("messages")
                        .collection(FirebaseAuth.instance.currentUser!.uid)
                        .orderBy("timestamp")
                        .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
                  if (messages.isEmpty) {
                    return SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.1,
                            // ),
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Color(0xFFC18C71),
                                  width: 3,
                                ),
                              ),
                              child: Text(
                                "No Questions Yet. Feel free to start asking questions. We'll try our best to respond as soon as possible",
                                style: GoogleFonts.lexend(
                                  fontSize: 14.sp,
                                  color: Color(0xFF4D9078),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final currentMessage = messages[index];
                        bool isUser = currentMessage["user"] == 'user';
                        return SafeArea(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    isUser
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.start,

                                children: [
                                  !isUser
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20.0,
                                        ),
                                        child: CircleAvatar(
                                          minRadius: 20.r,
                                          child: Icon(
                                            Icons.support_agent,
                                            size: 25.r,
                                          ),
                                        ),
                                      )
                                      : SizedBox.shrink(),
                                  SizedBox(width: 20.w),
                                  !isUser
                                      ? Container(
                                        width:
                                            currentMessage["text"].length >= 25
                                                ? 200
                                                : null,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          color: Color(0xFFC18C71),
                                        ),

                                        child: Text(
                                          currentMessage['text'],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                      : Container(
                                        width:
                                            currentMessage["text"].length >= 25
                                                ? 200
                                                : null,
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                          color: Color(0XFF4D9078),
                                        ),

                                        child: Text(
                                          currentMessage['text'],
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                  isUser
                                      ? SizedBox(width: 20.w)
                                      : SizedBox.shrink(),
                                  isUser
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          right: 20.0,
                                        ),
                                        child: CircleAvatar(
                                          minRadius: 20.r,
                                          child: Icon(Icons.person, size: 25.r),
                                        ),
                                      )
                                      : SizedBox.shrink(),
                                ],
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

              BlocBuilder<ShowMenuBloc, ShowMenuState>(
                builder: (context, state) {
                  if (state is ToggleInfoState) {
                    showInfo = !state.value;
                  }
                  return Align(
                    alignment: Alignment(-0.8, -1),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 300),
                      child:
                          showInfo
                              ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFC18C71),
                                    width: 3.w,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      width: 100.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color(0xFF4D9078),
                                            size: 25.sp,
                                          ),
                                          Icon(
                                            Icons.folder_outlined,
                                            color: Color(0XFF4D9078),
                                            size: 25.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),
                                child: SizedBox.shrink(),
                              ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<ShowMenuBloc>(
                          context,
                        ).add(ClickAddEvent(value: showInfo));
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 33.sp,
                        color: Color(0xFF374B81),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SafeArea(
                      child: Container(
                        decoration: BoxDecoration(),
                        width: 310.w,
                        height: 40.h,
                        child: TextField(
                          controller: controller,
                          onSubmitted: (value) async {
                            await sendMsg(value.trim());
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Message",
                            hintStyle: GoogleFonts.manrope(
                              color: Color(0xFF374b81),
                              fontSize: 14.sp,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w,
                              vertical: 4.h,
                            ),
                            enabled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(color: Color(0xFFC18C71)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.r),
                              borderSide: BorderSide(
                                color: Color(0xFFC18C71),
                                width: 3,
                              ),
                            ),

                            suffixIcon: IconButton(
                              onPressed: () async {
                                await sendMsg(controller.text.trim());
                              },
                              icon: Transform.rotate(
                                angle: -pi / 2,
                                child: Icon(
                                  Icons.send,

                                  color: Color(0xFF374B81),
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        );
  }
}


// user can only chat with admin
// when they put in a message it goes to a specific document bsed on the user id 
