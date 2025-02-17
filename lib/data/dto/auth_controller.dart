import 'dart:convert';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var isLoggedIn = false.obs;
  var token = "".obs;
  var firstName = "".obs;
  var lastName = "".obs;
   RxString phoneNumber = "".obs;
   RxString wasteWeight = "".obs;
   RxString level = "".obs;
   RxString points = "".obs;
   RxBool isVerified = false.obs;

  final String baseUrl = "https://backend.energychleen.ng/api"; // Replace with energy chleen actual backend URL

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

// register logic
Future<void> register(
  BuildContext context, {required String firstName, required String lastName, required String password, required String confirmPassword, required String email, required String phoneNumber}) async {

// String email = _emailController.text.trim();
String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

if (!RegExp(emailPattern).hasMatch(email)) {
  Get.snackbar(
    backgroundColor: Customcolors.red,
    colorText: Customcolors.white,
    "Error", "Please enter a valid email address");
    print('Valid email: $email');  // For testing
  return;  // Stop further execution if the email is invalid
} else {
  print('Valid email: $email');  // For testing
}

  // Check if password and confirmation match
  if (password != confirmPassword) {
    Get.snackbar(
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
      "Error", "Password and confirmation do not match");
    return;
  }

  try {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: jsonEncode({
        "firstName": "$firstName", // I'll try to Concatenate firstName and lastName later if it keeps failing
        "lastName": lastName, 
        "email": email,
        "password": password,
        "password_confirmation": confirmPassword,  // Send confirmation field
        "phoneNumber": phoneNumber,
      }),
    );

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      String message = responseData['message'];
      
      Get.snackbar(
        backgroundColor: Customcolors.green,
        colorText: Customcolors.white,
        "Success", message);
        showOtpDialog(context, email: email);
    } else {
      print(email);
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      var responseData = jsonDecode(response.body);
      showOtpDialog(context, email: email);
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error", responseData['message'] ?? 'Registration failed');
    }
  } catch (e) {
    print(email);
    print('Exception: $e');
    Get.snackbar(
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
      "Error", e.toString());
    print(e);
  }
}


Future<void> verifyEmail(String email, String otp,) async {
  final url = Uri.parse('$baseUrl/verify-email');
  
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'email': email,
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success response
      final jsonResponse = jsonDecode(response.body);
      print('Success: ${jsonResponse['message']}');
      
      Get.snackbar(
        "Success",
        'Email verified successfully!',
        backgroundColor: Customcolors.green,
        colorText: Customcolors.white,
      );
      Get.offAllNamed('homepage');
    } else {
      // Handle error response
      print('Error: ${response.body}');
      
      Get.snackbar(
        "Failed",
        'Failed to verify email',
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
      );
    }
  } catch (e) {
    print('Error occurred: $e');
    
    Get.snackbar(
      "Failed",
      'An error occurred',
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
    );
  }
}


  // Login Method
  Future<void> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // Parse the response to extract the token
      final responseData = json.decode(response.body);
      String fetchedToken = responseData['token'] ?? "";

      // Save token and user info to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", fetchedToken);
      await prefs.setString("firstName", responseData['firstName'] ?? "");
      await prefs.setString("lastName", responseData['lastName'] ?? "");

      token.value = fetchedToken;
      firstName.value = responseData['firstName'] ?? "";
      lastName.value = responseData['lastName'] ?? "";
      isLoggedIn.value = true;

      Get.snackbar(
        backgroundColor: Customcolors.green,
        colorText: Customcolors.white,
        "Success", "Logged in successfully!");
      Get.offAllNamed('homepage');
      AuthController.instance.fetchUserDetails();
    } else {
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error", "Invalid credentials");
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
    await prefs.remove("firstName");
    await prefs.remove("lastName");
    token.value = "";
    firstName.value = "";
    lastName.value = "";
    isLoggedIn.value = false;
    Get.offAllNamed("/login");
  }

// Check if User is Logged In
Future<void> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token.value = prefs.getString("token") ?? "";
  isLoggedIn.value = token.value.isNotEmpty;
  firstName.value = prefs.getString("firstName") ?? "";
  lastName.value = prefs.getString("lastName") ?? "";
  final userId = prefs.getString("userId") ?? ""; // Retrieve userId from SharedPreferences

  if (isLoggedIn.value && userId.isNotEmpty) {
    print(firstName.value);
    // Fetch user data from backend
    await fetchUserDetails(); // Pass userId to fetchUserDetails
  } else {
    firstName.value = firstName.toString();
    lastName.value = lastName.toString();
  }
}

Future<void> fetchUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString("userId") ?? ""; // Retrieve userId from SharedPreferences
  final url = "$baseUrl/users/$userId"; // Insert the user ID into the URL

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer ${token.value}", // Ensure token is passed correctly
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      // Parse the response body to extract user details
      final data = json.decode(response.body);

      // Ensure all relevant fields from the API response are handled
      firstName.value = data['firstName'] ?? "";
      lastName.value = data['lastName'] ?? "";
      phoneNumber.value = data['phoneNumber'] ?? "";
      wasteWeight.value = data['wasteWeight'] ?? "";
      points.value = data['points'] ?? "";
      isVerified.value = data['isVerified']?.toString().toLowerCase() == "true";

      // Parse nested fields such as 'level'
      if (data['level'] != null) {
        level.value = data['level']['name'] ?? "";
      }

      // Optionally log or store additional details
      print("User details fetched successfully");
    } else {
      print("Failed to fetch user details: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching user details: $e");
  }
}
  // TODO: Create a function for deleting account

void showOtpDialog(
  BuildContext context, {
  required String email, // Make email required since you are using it
  int maxLength = 6,
}) {
  final _otpController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Enter OTP',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please enter the 6-digit OTP sent to your email.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextFormField(
              style: TextStyle(fontSize: 18),
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: maxLength,
              decoration: InputDecoration(
                hintText: 'Enter OTP',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Customcolors.teal,
            ),
            onPressed: () {
              final otp = _otpController.text; // Capture the OTP here
              if (otp.length == maxLength) {
                print('OTP Entered: $otp');
                AuthController.instance.fetchUserDetails();
                // Call the verifyEmail function
                AuthController.instance.verifyEmail(
                  email, // No need for a bang (!) operator
                  otp,
                );

                Navigator.of(context).pop(); // Close the dialog
              } else {
                Get.snackbar(
                  "Failed",
                  'Invalid OTP!',
                  backgroundColor: Customcolors.red,
                  colorText: Customcolors.white,
                );
                print('Invalid OTP');
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      );
    },
  );
}

}
