import 'dart:convert';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var isLoggedIn = false.obs;
  var token = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;

  final String baseUrl = "https://your-backend-url.com/api"; // Replace with energy chleen actual backend URL

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Register Method
  Future<void> register(String firstName, String lastName, String password, String email, String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
          
        }),
      );

      if (response.statusCode == 201) { // Assuming 201 for success
        Get.snackbar(
          backgroundColor: Customcolors.green,
          colorText: Customcolors.white,
          "Success", "Account created! logging in...");
          Get.offAllNamed('homepage');
      } else {
        Get.snackbar(
          backgroundColor: Customcolors.red,
          colorText: Customcolors.white,
          "Error", "Registration failed");
      }
    } catch (e) {
      Get.snackbar(
        backgroundColor: Customcolors.red,
          colorText: Customcolors.white,
        "Error", e.toString());
 }
}

  // Login Method
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        token.value = data["token"];

        // Save token in local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token.value);

        isLoggedIn.value = true;
        Get.snackbar(
          backgroundColor: Customcolors.green,
          colorText: Customcolors.white,
          "Success", "Logged in successfully!");
          Get.offAllNamed('homepage');
      } else {
        Get.snackbar(
          backgroundColor: Customcolors.red,
          colorText: Customcolors.white,"Error", "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar(
        backgroundColor: Customcolors.red,
          colorText: Customcolors.white,
        "Error", e.toString());
    }
  }

  // Logout Method
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    token.value = "";
    isLoggedIn.value = false;
    firstName.value = "";
    lastName.value = "";
    Get.offAllNamed("/login");
  }

  // Check if User is Logged In
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString("token") ?? "";
    isLoggedIn.value = token.value.isNotEmpty;
    firstName.value =prefs.getString("firstName") ?? "Guest";
    lastName.value =prefs.getString("lastName") ?? "";
  }
}