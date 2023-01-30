import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/splash_screen/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "SuperVision",
    options: const FirebaseOptions(
      apiKey: "AIzaSyAiMr3ciMiHaBtNTcaUB5VFIpAmVKKXk8k",
      appId: "1:790155127350:android:2b8ee071513252e08dc697",
      messagingSenderId: "790155127350",
      projectId: "supervision-3f340",
      storageBucket: "gs://supervision-3f340.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final Color myColor = const Color(0xFF104D5B);

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.teal),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "US"),
        Locale("bn", "BD"),
      ],
      title: 'LeadTeam',
      home: const SplashScreen(),
    );
  }
}
