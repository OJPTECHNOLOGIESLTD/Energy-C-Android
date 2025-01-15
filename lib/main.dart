import 'package:energy_chleen/Pages/onboarding_screen/splash_screen.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle
    (statusBarColor: Colors.transparent));
    return MaterialApp(
      title: 'Energy Chleen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Customcolors.teal),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

