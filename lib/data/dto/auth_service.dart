import 'package:energy_chleen/utils/Helper.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static ApiService instance = Get.find();
  static const String _baseUrl = 'https://energychleen.net/backend';
    // Function to submit the form
  Future<void> submitHomePick(
     String pickupType,
     String address,
     String city,
     String state,
     DateTime selectedDate,
  ) async {
    final url = Uri.parse('$_baseUrl/your-api-url.com/api/pickup');
    
    Map<String, dynamic> pickupData = {
      "pickupType": pickupType,
      "address": address,
      "city": city,
      "state": state,
      "pickupDate": selectedDate.toIso8601String().substring(0, 10) // YYYY-MM-DD
    };
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(pickupData),
      );

      if (response.statusCode == 201) {
        // Success
          Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Success",'Pickup details submitted successfully!');
          
      } else {
        var responseData = jsonDecode(response.body);
        // Error
        Get.snackbar(
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
        "Error", responseData['message'] ?? 'Failed to submit pickup details');
      }
    } catch (e) {
    Get.snackbar(
      backgroundColor: Customcolors.red,
      colorText: Customcolors.white,
      "Error", e.toString());
  }
  }
}

