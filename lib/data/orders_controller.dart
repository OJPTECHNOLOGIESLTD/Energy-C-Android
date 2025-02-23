import 'dart:convert';

import 'package:energy_chleen/model/models.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  static OrdersController instance = Get.find();

  final String baseUrl = "https://backend.energychleen.ng/api";


Future<void> createOrder({
  required int userId,
  required int wasteItemId,
  required double totalWeight,
  required double totalPrice,
  required String date,
  required String address,
  required int cityId,
  required int stateId,
  required String pickupType,
  required List<Map<String, dynamic>> items,
}) async {
  final url = Uri.parse('$baseUrl/create');
  var token='';
  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer: $token', // Add your token if required
  };
  
  final body = jsonEncode({
    "userId": userId,
    "waste_item_id": wasteItemId,
    "totalWeight": totalWeight,
    "totalPrice": totalPrice,
    "date": date,
    "address": address,
    "cityId": cityId,
    "stateId": stateId,
    "pickupType": pickupType,
    "items": items
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      print('Order created successfully: ${responseData['order']}');
    } else {
      print('Failed to create order: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error: $e');
  }
}
  
}