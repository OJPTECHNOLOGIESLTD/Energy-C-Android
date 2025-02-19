import 'dart:async';
import 'package:energy_chleen/data/auth_service.dart';
import 'package:energy_chleen/screens/Auth_Screens/login.dart';
import 'package:energy_chleen/screens/Auth_Screens/signup.dart';
import 'package:energy_chleen/screens/navbar/navbar.dart';
import 'package:energy_chleen/screens/onboarding_screen/onboarding.dart';
import 'package:energy_chleen/data/auth_controller.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Get.put(AuthController()); // injecting authcontroller
  Get.lazyPut(()=>ApiService()); //or Get.lazyPut(()=>ApiService());
  }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle
    (statusBarColor: Colors.transparent));
    return GetMaterialApp(
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: ()=>SplashScreen()),
        GetPage(name: "/homepage", page: ()=>CustomBottomNav()),
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

class SplashApp extends StatefulWidget {
  @override
  State<SplashApp> createState() => _SplashAppState();
}

class _SplashAppState extends State<SplashApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to OnboardingScreen after 3 seconds
    Timer(Duration(seconds: 3), () {
      AuthController authController = Get.find<AuthController>();
      if (authController.isLoggedIn.value) {
        Get.offAllNamed('/homepage');  // Navigate to homepage if logged in
      } else {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/energy.png', width: 300),
            Text(
              'ENERGY CHLEEN',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'From Waste to Wealth',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}