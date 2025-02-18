import 'dart:convert';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  User? user;

  var isLoggedIn = false.obs;
  var token = "".obs;
  RxString firstName = "".obs;
  RxString lastName = "".obs;
  RxString phoneNumber = "".obs;
  RxString wasteWeight = "".obs;
  RxString level = "".obs;
  RxString points = "".obs;
  RxString createdAt = "".obs;
  RxString email = "".obs;
  RxBool isVerified = false.obs;

  final String baseUrl =
      "https://backend.energychleen.ng/api"; // Replace with energy chleen actual backend URL

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

// register logic
  Future<void> register(
    BuildContext context, {
    required String firstName,
    required String lastName,
    required String password,
    required String confirmPassword,
    required String email,
    required String phoneNumber,
  }) async {
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    if (!RegExp(emailPattern).hasMatch(email)) {
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error",
        "Please enter a valid email address",
      );
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error",
        "Password and confirmation do not match",
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "password_confirmation": confirmPassword,
          "phoneNumber": phoneNumber,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        String message = responseData['message'];
        print('Registration Response: ${response.body}'); // Debug log

        // Check if 'user' exists in response
        if (responseData.containsKey('user')) {
          var user = responseData['user'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('userId', user['id'].toString());
          await prefs.setString('firstName', user['firstName']);
          await prefs.setString('lastName', user['lastName']);
          await prefs.setString('email', user['email']);
          await prefs.setString('phoneNumber', user['phoneNumber']);
          await prefs.setBool('isVerified', user['isVerified'] ?? false);
          await prefs.setString('createdAt', user['created_at'] ?? '');

          await fetchUserDetails(); // Fetch updated details
        } else {
          print('User data missing in registration response');
        }

        Get.snackbar(
          backgroundColor: Customcolors.green,
          colorText: Customcolors.white,
          "Success",
          message,
        );
        showOtpDialog(context, email: email);
      } else {
        // Handle non-201 responses as errors
        var errorData = jsonDecode(response.body);
        Get.snackbar(
          backgroundColor: Customcolors.red,
          colorText: Customcolors.white,
          "error",
          'Failed $errorData',
        );
      }
    } catch (e) {
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error",
        e.toString(),
      );
      print(e);
    }
  }

  Future<void> verifyEmail(
    String email,
    String otp,
  ) async {
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
  final jsonResponse = json.decode(response.body);
  String fetchedToken = jsonResponse['token'] ?? "";

  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", fetchedToken);
  token.value = fetchedToken;

  // Immediately fetch updated user details
  await fetchUserDetails();

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
        final responseData = json.decode(response.body);
        String fetchedToken = responseData['token'] ?? "";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", fetchedToken);
        await prefs.setString(
            "userId", responseData['id'] ?? ""); // Save userId
        isLoggedIn.value = true;

        await fetchUserDetails(); // Add this line to fetch user data after login
        Get.snackbar(
            backgroundColor: Customcolors.green,
            colorText: Customcolors.white,
            "Success",
            "Logged in successfully!");
        Get.offAllNamed('homepage');
      } else {
        Get.snackbar(
            backgroundColor: Customcolors.red,
            colorText: Customcolors.white,
            "Error",
            "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: Customcolors.red,
          colorText: Customcolors.white,
          "Error",
          e.toString());
    }
  }

  // Logout Method
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    await prefs.remove("firstName");
    await prefs.remove("lastName");
    await prefs.remove("id");
    await prefs.remove("email");
    await prefs.remove("phoneNumber");
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

    if (isLoggedIn.value) {
      await fetchUserDetails(); // Ensure you fetch user details if logged in
    }
  }

  Future<void> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId =
        prefs.getString('userId'); // Retrieve userId from SharedPreferences

    if (userId != null && userId.isNotEmpty) {
      final url =
          Uri.parse('$baseUrl/users/:id'); // Correct endpoint with userId
      try {
        final response = await http.get(url, headers: {
          'Authorization':
              'Bearer ${prefs.getString("token")}' // Pass the token for authentication
        });

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          // Save additional user data to SharedPreferences
await prefs.setString('email', data['email']);
await prefs.setString('phoneNumber', data['phoneNumber']);
await prefs.setBool('isVerified', data['isVerified'] ?? false);
await prefs.setString('createdAt', data['created_at'] ?? '');

          // Update your controller state
          firstName.value = data['firstName'] ?? "";
          lastName.value = data['lastName'] ?? "";
          email.value = data['email'] ?? "";
          phoneNumber.value = data['phoneNumber'] ?? "";
          isVerified.value = data['isVerified'] ?? false;

          print('User details fetched and saved successfully!');
        } else {
          print('Failed to fetch user details: ${response.statusCode}');
        }
      } catch (e) {
        print('Error fetching user details: $e');
      }
    } else {
      print('User ID is missing.');
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
              onPressed: () async {
                final otp = _otpController.text; // Capture the OTP here
                if (otp.length == maxLength) {
                  print('OTP Entered: $otp');
                  // Call the verifyEmail function
                  //  await  AuthController.instance.loadUserData();
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

// load saved data from shared prefence after registration
  Future<Map<String, dynamic>> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print({
      'id': prefs.getString('id') ?? '',
      'firstName': prefs.getString('firstName') ?? '',
      'lastName': prefs.getString('lastName') ?? '',
      'email': prefs.getString('email') ?? '',
      'phoneNumber': prefs.getString('phoneNumber') ?? '',
      'isVerified': prefs.getBool('isVerified') ?? false,
      'createdAt': prefs.getString('createdAt') ?? '',
    });
    return {
      'id': prefs.getString('id') ?? '',
      'firstName': prefs.getString('firstName') ?? '',
      'lastName': prefs.getString('lastName') ?? '',
      'email': prefs.getString('email') ?? '',
      'phoneNumber': prefs.getString('phoneNumber') ?? '',
      'isVerified': prefs.getBool('isVerified') ?? false,
      'createdAt': prefs.getString('createdAt') ?? '',
    };
  }
}
