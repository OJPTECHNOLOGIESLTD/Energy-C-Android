import 'dart:convert';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var user = RxMap<String, dynamic>({}); // Correct way to initialize an RxMap

  var isLoggedIn = false.obs;
  var token = ''.obs;
  Rx<User?> userDetails = Rx<User?>(null); // Reactive user object
  Rx<LevelProgress?> progressDetails = Rx<LevelProgress?>(null);
  Rx<PurchaseModel?> purchasedModel = Rx<PurchaseModel?>(null);
  Rx<WasteItem?> wasteDetails = Rx<WasteItem?>(null);

  final String baseUrl = "https://backend.energychleen.ng/api";

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegExp.hasMatch(email);
  }

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> register(String firstName, String lastName, String email,
      String password, String confirmPassword, String phoneNumber) async {
    if (!isValidEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please provide a valid email address.",
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
      );
      return;
    }

    // Proceed with the registration API call
    await _makePostRequest(
      endpoint: 'register',
      body: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phoneNumber": phoneNumber
      },
      onSuccess: (responseData) async {
        await saveLoginResponse(responseData);
        Get.snackbar("Success", "User registered successfully!",
            backgroundColor: Customcolors.green, colorText: Customcolors.white);
      },
    );
  }

Future<void> login(String email, String password) async {
  if (!isValidEmail(email)) {
    Get.snackbar(
      "Invalid Email",
      "Please provide a valid email address.",
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
    );
    return;
  }

  await _makePostRequest(
    endpoint: 'login',
    body: {"email": email, "password": password},
    onSuccess: (responseData) async {
      await saveLoginResponse(responseData);

      // Ensure token is saved properly
      var token = responseData['token'];
      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Token is null or empty",
            backgroundColor: Customcolors.red, colorText: Customcolors.white);
        return;
      }

      isLoggedIn.value = true; // Use .value to update RxBool
      await fetchUser();
      Get.snackbar("Success", "Logged in successfully!",
          backgroundColor: Customcolors.green, colorText: Customcolors.white);
      Get.offAllNamed('homepage');
    },
  );
}




  Future<void> verifyEmail(String email, String otp) async {
    await _makePostRequest(
      endpoint: 'verify-email',
      body: {"email": email, "otp": otp},
      onSuccess: (responseData) async {
        await saveLoginResponse(responseData);
        Get.snackbar("Success", "Email verified successfully!",
            backgroundColor: Customcolors.green, colorText: Customcolors.white);
        Get.offAllNamed('login');
        isLoggedIn == true;
        await fetchUser();
      },
    );
  }

  Future<void> fetchUser() async {
    try {
      if (token.value.isEmpty) {
        print('Error: Token is null or empty');
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/user'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token.value}',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Extract the 'user' object from the responseData
        final userData = responseData['user'];
        print('User data fetched: $userData');
        // Ensure userData is valid before assigning it
        if (userData != null && userData is Map<String, dynamic>) {
          userDetails.value =
              User.fromJson(userData); // Parse user object to User model
          print('User details set successfully: ${userDetails.value}');
        } else {
          print('Error: User data is null or not in expected format');
        }
      } else {
        print('Failed to fetch user details: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching user details: $e');
    }
  }

Future<void> fetchLevelProgress() async {
  // Only fetch if progressDetails are null
  if (progressDetails.value != null) {
    print('Progress details already fetched: ${progressDetails.value}');
    return;
  }

  // final id = userDetails.value!.id;
  final url = Uri.parse("$baseUrl/${userDetails.value?.id}/level-progress");

  try {
    final response = await http.get(url);

    print('Fetching level progress from: $url');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');  // Log the full response body

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      print('Decoded data: $data');

      progressDetails.value = LevelProgress.fromJson(data);
      print("Progress details fetched: ${progressDetails.value}");
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching data: $e");
  }
}


  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    token.value = '';
    userDetails.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed("/login");
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString("token") ?? '';
    isLoggedIn.value = token.value.isNotEmpty;

    print("Token: ${token.value}");
    print("Is Logged In: ${isLoggedIn.value}");

    if (isLoggedIn.value) {
      await fetchUser(); // Fetch user details if logged in
    }
  }

Future<void> saveLoginResponse(Map<String, dynamic> responseData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Save the whole response for debugging
  await prefs.setString('loginResponse', json.encode(responseData));

  // Save token if it exists
  if (responseData.containsKey('token')) {
    await prefs.setString("token", responseData['token']);
    print("Saved token: ${responseData['token']}");
  } else {
    print("Token not found in response.");
  }

  // Save user ID
  if (responseData.containsKey('user')) {
    await prefs.setString("userId", responseData['user']['id'].toString());
    print("Saved user ID: ${responseData['user']['id']}");
  } else {
    print("User not found in response.");
  }

  // Mark user as logged in
  await prefs.setBool('isLoggedIn', true); // Save login status

  // Retrieve and log the token for debugging
  String? savedToken = prefs.getString('token');
  print("Retrieved token from SharedPreferences: $savedToken");

  print("User data and login status saved successfully");
}


  Future<void> _makePostRequest({
    required String endpoint,
    required Map<String, dynamic> body,
    required Function(Map<String, dynamic>) onSuccess,
  }) async {
    try {
      print("Making request to $baseUrl/$endpoint");
      print("Request body: ${jsonEncode(body)}");

      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      print("Response status: ${response.statusCode}");
      print(
          "Response body: ${response.body}"); // Print full response for debugging

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        await onSuccess(responseData);
      } else {
        final errorResponse = json.decode(response.body);
        print("Error from server: ${errorResponse}");

        final errorMessage = errorResponse['message'] ?? 'Invalid input';
        Get.snackbar("Error", errorMessage,
            backgroundColor: Customcolors.red, colorText: Customcolors.white);
      }
    } catch (e) {
      print("Exception: $e");
      Get.snackbar("Error", e.toString(),
          backgroundColor: Customcolors.red, colorText: Customcolors.white);
    }
  }

Future<Map<String, dynamic>?> getSavedUserDetails() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedResponse = prefs.getString('loginResponse');

  if (savedResponse != null) {
    print('Retrieved saved response: $savedResponse');

    try {
      Map<String, dynamic> decodedResponse = Map<String, dynamic>.from(json.decode(savedResponse));

      // Check if 'user' key exists in the decoded response
      if (decodedResponse.containsKey('user')) {
        Map<String, dynamic> decodedUser = decodedResponse['user'];

        // Assign the decoded user to the reactive map
        user.assignAll(decodedUser);
        print('Decoded user details: $decodedUser');

        return decodedResponse;
      } else {
        print("'user' key not found in the saved response.");
      }
    } catch (e) {
      print('Error decoding saved response: $e');
    }
  } else {
    print('No saved response found in SharedPreferences');
  }

  return null;
}


// Example of displaying user details
  Future<void> displayUserData() async {
    final userDetails = await getSavedUserDetails();

    if (userDetails != null) {
      print('First Name: ${userDetails['firstName']}');
      print('Last Name: ${userDetails['lastName']}');
      print('Email: ${userDetails['email']}');
      print('Token: ${userDetails['verificationToken']}');
    } else {
      print('No user data found');
    }
  }

Future<WasteItem> getWasteItemDetails() async {
  final url = Uri.parse("$baseUrl/waste-items");

  try {
    final response = await http.get(url);

    print('Fetching waste item from: $url');
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      print('Decoded data: $data');

      // Update the wasteDetails only with the first waste item, assuming the response has an array
      final wasteItemData = (data['waste_items'] as List).first;
      wasteDetails.value = WasteItem.fromJson(wasteItemData);

      print("Waste item fetched: ${wasteDetails.value}");
      return wasteDetails.value!;  // Always return the fetched WasteItem
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error fetching waste item data: $e");
    throw Exception("Error fetching waste item data: $e");
  }
}

  void updateWasteWeight(int newWeight) {
    wasteDetails.update((val) {
      if (val != null) {
        val.weight = newWeight;
      }
    });
  }
}

