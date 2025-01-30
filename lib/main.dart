import 'package:energy_chleen/Auth/login.dart';
import 'package:energy_chleen/Auth/signup.dart';
import 'package:energy_chleen/Pages/onboarding_screen/splash_screen.dart';
import 'package:energy_chleen/data/dto/auth_controller.dart';
import 'package:energy_chleen/navbar/homepage.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Get.put(AuthController()); // injecting authcontroller
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle
    (statusBarColor: Colors.transparent));
    return GetMaterialApp(
      initialRoute: "/splashIscreen",
      getPages: [
        GetPage(name: "/splash_screen", page: ()=>SplashScreen()),
        GetPage(name: "/homepage", page: ()=>HomePage()),
        GetPage(name: "/login", page: ()=>Login()),
        GetPage(name: "/signup", page: ()=>Signup()),
      ],
      title: 'Energy Chleen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Customcolors.teal),
        useMaterial3: true,
      ),
    );
  }
}

