import 'package:flutter/material.dart';

class Customcolors {
  Customcolors._();

  static const Color teal = Color.fromRGBO(33, 124, 112, 1);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color yellow = Color.fromRGBO(252, 188, 98, 1);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color offwhite = Color.fromRGBO(231,227,198, 1);
  static const Color paymentBlue = Color.fromRGBO(30, 90, 132, 1);
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
    colors: [
      Colors.blue,
      Colors.cyan,
      Colors.green,
    ],
  );
}

class CustomTexts
 {
  static TextStyle boldtext=TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
}