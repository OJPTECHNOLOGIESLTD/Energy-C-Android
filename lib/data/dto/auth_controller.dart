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

  final String baseUrl = "https://54f7005e-c626-423e-8c42-5580a9c9d43b.mock.pstmn.io"; // Replace with energy chleen actual backend URL

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
      var responseData = jsonDecode(response.body);
      Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error", responseData['message'] ?? 'Registration failed');
    }
  } catch (e) {
    Get.snackbar(
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
      "Error", e.toString());
  }
}

// uncomment if need be

// Future<void> register(String firstName, String lastName, String password, String email, String phoneNumber, File? profilePicture) async {
//   try {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse("$baseUrl/users/register"),
//     );

//     // Add text fields
//     request.fields['firstName'] = firstName;
//     request.fields['lastName'] = lastName;
//     request.fields['email'] = email;
//     request.fields['password'] = password;
//     request.fields['phoneNumber'] = phoneNumber;

//     // Add profile picture if it exists
//     if (profilePicture != null) {
//       request.files.add(await http.MultipartFile.fromPath(
//         'profile_picture', 
//         profilePicture.path,
//         filename: basename(profilePicture.path),
//       ));
//     }

//     // Send request
//     final response = await request.send();
//     final responseBody = await http.Response.fromStream(response);

//     if (response.statusCode == 201) { // Assuming 201 for success
//       Get.snackbar(
//         backgroundColor: Customcolors.green,
//         colorText: Customcolors.white,
//         "Success", "Account created! logging in..."
//       );
//       Get.offAllNamed('homepage');
//     } else {
//       var responseData = jsonDecode(responseBody.body);
//       Get.snackbar(
//         backgroundColor: Customcolors.red,
//         colorText: Customcolors.white,
//         "Error", responseData['message'] ?? 'Registration failed'
//       );
//     }
//   } catch (e) {
//     Get.snackbar(
//       backgroundColor: Customcolors.red,
//       colorText: Customcolors.white,
//       "Error", e.toString()
//     );
//   }
// }

  // Login Method
  Future<void> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          backgroundColor: Customcolors.green,
          colorText: Customcolors.white,
          "Success", "Logged in successfully!");
        Get.offAllNamed('homepage');
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
    firstName.value = "s";
    lastName.value = "";
    isLoggedIn.value = false;
    Get.offAllNamed("/login");
  }

  // // Check if User is Logged In
  // Future<void> checkLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   token.value = prefs.getString("token") ?? "";
  //   firstName.value = prefs.getString("firstName") ?? "Guest";
  //   lastName.value = prefs.getString("lastName") ?? "";
  //   isLoggedIn.value = token.value.isNotEmpty;
  // }

  Future<void> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token.value = prefs.getString("token") ?? "";
  isLoggedIn.value = token.value.isNotEmpty;

  if (isLoggedIn.value) {
    print(firstName.value);
    // Fetch user data from backend
    await fetchUserDetails();
  } else {
    firstName.value = firstName.toString();
    lastName.value = lastName.toString();
  }
}

Future<void> fetchUserDetails() async {
  final url = "$baseUrl/user/info"; // Replace with your backend endpoint

  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token", // Sending token as bearer authentication
      },
    );

    if (response.statusCode == 200) {
      print('Bearer $token');
      // Parse the response body to extract user details
      final data = json.decode(response.body);

      // Ensure the data contains 'firstName' and 'lastName'
      firstName.value = data['firstName'] ?? "";
      lastName.value = data['lastName'] ?? "";
    } else {
      // Handle unsuccessful response
      firstName.value = "";
      lastName.value = "";
    }
    print(response.body); 
  } catch (e) {
    // Handle any errors during the request
    print("Error fetching user details: $e");
    firstName.value = "";
    lastName.value = "";
  }
}

  // TODO: Create a function for deleting account
}
