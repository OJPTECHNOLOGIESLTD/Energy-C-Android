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
    // Get.snackbar("Success", "Email verified successfully!",
    //         backgroundColor: Customcolors.green, colorText: Customcolors.white);
    throw Exception('Error fetching news/events: $e');
  }
 }
}


