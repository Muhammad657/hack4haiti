import 'package:ecoeats/bloc/show_menu_bloc.dart';
import 'package:ecoeats/chat/chat.dart';
import 'package:ecoeats/firebase_options.dart';
import 'package:ecoeats/hackathon/bloc/language_bloc.dart';
import 'package:ecoeats/hackathon/chat.dart';
import 'package:ecoeats/hackathon/gnav.dart';
import 'package:ecoeats/hackathon/home_offline.dart';
import 'package:ecoeats/hackathon/main%20(1).dart';
import 'package:ecoeats/hackathon/onboardingoflinepage.dart';
import 'package:ecoeats/hackathon/onboardingpage.dart';
import 'package:ecoeats/hackathon/resultpage.dart';
import 'package:ecoeats/hackathon/texttospeech.dart';
import 'package:ecoeats/other%20stuff/gnav.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecoeats/other%20stuff/home.dart';
import 'package:ecoeats/other%20stuff/tts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  Hive.openBox("username");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(397, 865),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ShowMenuBloc()),
            BlocProvider(create: (context) => LanguageBloc()),
          ],

          child: MaterialApp(
            theme: ThemeData(brightness: Brightness.light),
            debugShowCheckedModeBanner: false,
            home: OnboardingOfflinePage(),
          ),
        );
      },
    );
  }
}
