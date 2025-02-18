import 'package:energy_chleen/model/models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService extends GetxService  {
  static ApiService instance = Get.find();
  static const String baseUrl = "https://backend.energychleen.ng/api";

    @override
  void onInit() {
    super.onInit();
    fetchNewsEvents();
  }
    // Function to submit the form
Future<void> createOrder({
  required String userId,
  required List<Map<String, dynamic>> items, // List of waste items
  required String totalWeight,
  required String totalPrice,
  required String pickupAddress,
  required String city,
  required String state,
  required String pickupType, // Home or Station
  String? status = 'Pending', // Default status
  List<String>? supportingImages, // Optional images
}) async {
  final url = Uri.parse('$baseUrl/api/orders'); // Replace with actual URL

  // Prepare the request body
  final body = jsonEncode({
    'userId': userId,
    'items': items,
    'totalWeight': totalWeight,
    'totalPrice': totalPrice,
    'pickupAddress': pickupAddress,
    'city': city,
    'state': state,
    'pickupType': pickupType,
    'status': status,
    'supportingImages': supportingImages,
  });

  // Make the POST request
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  // Handle the response
  if (response.statusCode == 201) {
    final responseData = jsonDecode(response.body);
    print('Order created successfully. Order ID: ${responseData['orderId']}');
  } else {
    print('Failed to create order. Status code: ${response.statusCode}');
  }
}
Future<void> getOrderDetails(String orderId) async {
  final url = Uri.parse('https://yourapiurl.com/api/orders/$orderId'); // Replace with actual URL

  // Make the GET request
  final response = await http.get(url);

  // Handle the response
  if (response.statusCode == 200) {
    final responseData = jsonDecode(response.body);
    print('Order Details: $responseData');
  } else {
    print('Failed to retrieve order details. Status code: ${response.statusCode}');
  }
}

  // Fetching news and events
Future<List<NewsEvent>> fetchNewsEvents() async {
  try {
    final url = Uri.parse('$baseUrl/news-events'); // Correct endpoint
    final response = await http.get(url).timeout(
      Duration(seconds: 10),
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
    throw Exception('Error fetching news/events: $e');
  }
 }
}


