import 'dart:async';
import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/order_completed.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetxService  {
  static ApiService instance = Get.find();
  static const String baseUrl = "https://backend.energychleen.ng/api";

    @override
  void onInit() {
    super.onInit();
    fetchNewsEvents();
  }
 // Method to fetch order details by ID
  Future<Order?> getOrderDetails(String orderId) async {
    final String url = '$baseUrl/$orderId';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the JSON response and return the Order object
        final Map<String, dynamic> data = json.decode(response.body);
        return Order.fromJson(data);
      } else {
        // Handle non-200 responses
        print('Failed to load order details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle error
      print('Error fetching order details: $e');
      return null;
    }
  }

  // Fetching news and events
Future<List<NewsEvent>> fetchNewsEvents() async {
  try {
    final url = Uri.parse('$baseUrl/news-events');
    final response = await http.get(url).timeout(
      Duration(seconds: 40),
    );

    // Log the response body
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Check if content type is application/json
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        List<dynamic> data = json.decode(response.body);
        return data.map((event) => NewsEvent.fromJson(event)).toList();
      } else {
        throw Exception('Invalid response format. Expected JSON.');
      }
    } else if (response.statusCode == 404) {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message'] ?? 'No news or events found.');
    } else {
      throw Exception('Failed to load news/events. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Get.snackbar("Success", "Email verified successfully!",
    //         backgroundColor: Customcolors.green, colorText: Customcolors.white);
    throw Exception('Error fetching news/events: $e');
  }
 }

Future<void> createPost({
  required BuildContext context,
  required String date,
  required String address,
  required int cityId,
  required int stateId,
  required String pickupType, // Make sure this matches one of the valid values
  required List<Map<String, dynamic>> wasteItems,
  required List<File> images,
  required List<File> videos,
}) async {
  final dio.Dio dioInstance = dio.Dio();

  // Add cookie management
  dioInstance.interceptors.add(CookieManager(CookieJar()));

  // Define the API URL
  final url = '$baseUrl/orders/create/${AuthController.instance.userDetails.value!.id}'; // Full URL

  // Get token from SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';

  // Define headers with Authorization
  final headers = {
    'Content-Type': 'multipart/form-data', // Important for file uploads
    'Authorization': 'Bearer $token',
    'Accept': 'application/json',  // Added Accept header
  };

  // Ensure pickupType is valid
  print('pickupType: $pickupType'); // Log pickupType to verify it's valid

  // Convert images and videos to dio.MultipartFile
  List<dio.MultipartFile> imageFiles = [];
  for (var image in images) {
    imageFiles.add(await dio.MultipartFile.fromFile(image.path, filename: image.path.split('/').last));
  }

  List<dio.MultipartFile> videoFiles = [];
  for (var video in videos) {
    videoFiles.add(await dio.MultipartFile.fromFile(video.path, filename: video.path.split('/').last));
  }

  // Create FormData
  final formData = dio.FormData.fromMap({
    "date": date,
    "address": address,
    "cityId": cityId,
    "stateId": stateId,
    "pickupType": pickupType,  // Ensure this matches a valid type from the API
    "waste_items": wasteItems, // Pass wasteItems directly as an array
    "images[]": imageFiles, // Add the list of image files, making sure to use 'images[]' if that's the expected key
    "videos[]": videoFiles, // Add the list of video files, similarly using 'videos[]' if that's expected
  });

  try {
    // Send the POST request
    final response = await dioInstance.post(
      url,
      data: formData,
      options: dio.Options(
        headers: headers,
        followRedirects: false, // Disable following redirects
        validateStatus: (status) {
          return status != null && status < 500; // Allow status codes < 500
        },
      ),
    );

    // Log the response for debugging
    print('Response status code: ${response.statusCode}');
    print('Response headers: ${response.headers}');
    print('Response body: ${response.data}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Data posted successfully');
     Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => OrderCompleted()),
  //(route) => false, // This removes all previous routes
);


    } else {
      print('Failed to post data. Status code: ${response.statusCode}');
      print('Response body: ${response.data}');
    }
  } catch (e) {
    // Handle Dio specific errors
    if (e is dio.DioError) {
      print('DioError: ${e.message}');
    } else {
      print('Error: $e');
    }
  }
}

Future<List<Message>> fetchMessages() async {
    final url = Uri.parse("$baseUrl/user/${AuthController.instance.userDetails.value!.id}/messages");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> messagesJson = data['messages'];

        return messagesJson.map((json) => Message.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        throw Exception("User not found");
      } else {
        throw Exception("Failed to load messages");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

Future<bool> markMessageAsRead(int messageId) async {
  final url = Uri.parse("$baseUrl/user/$messageId/mark-as-read");
  try {
    final response = await http.post(url);

    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body);
      return data['data']['is_read'] == 1; // Check if marked as read
    } else {
      // Log error but don't display to the user
      print('Failed to mark message as read. Status code: ${response.statusCode}');
      return false; // Indicating the message was not marked as read
    }
  } catch (e) {
    // Log any exceptions
    print('Error marking message as read: $e');
    return false; // Return false in case of error
  }
}

Future<int> getUnreadMessageCount() async {
  final url = Uri.parse("$baseUrl/user/${AuthController.instance.userDetails.value!.id}/unread-count");

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Ensure the response contains 'unread_count' and it is an integer
      if (data != null && data.containsKey('unread_count') && data['unread_count'] is int) {
        return data['unread_count']; // Return the unread message count
      } else {
        throw Exception("Unread count not found or invalid format");
      }
    } else {
      throw Exception("Failed to fetch unread count. Status code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
    throw Exception("Error fetching unread count: $e");
  }
}

}




