// services/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Save pickup details
  Future<void> savePickupDetails({
    required String pickupAddress,
    required String city,
    required String state,
    required DateTime pickupDate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pickupAddress', pickupAddress);
    await prefs.setString('city', city);
    await prefs.setString('state', state);
    await prefs.setString('pickupDate', pickupDate.toIso8601String());
  }

  // Load pickup details
  Future<Map<String, dynamic>> loadPickupDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pickupAddress = prefs.getString('pickupAddress');
    String? city = prefs.getString('city');
    String? state = prefs.getString('state');
    String? pickupDateStr = prefs.getString('pickupDate');
    DateTime? pickupDate;
    if (pickupDateStr != null) {
      pickupDate = DateTime.parse(pickupDateStr);
    }
    return {
      'pickupAddress': pickupAddress,
      'city': city,
      'state': state,
      'pickupDate': pickupDate,
    };
  }

  // Save waste details
  Future<void> saveWasteDetails({
    required String wasteType,
    required int weight,
    required int estPrice,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wasteType', wasteType);
    await prefs.setInt('weight', weight);
    await prefs.setInt('estPrice', estPrice);
  }

  // Load waste details
  Future<Map<String, dynamic>> loadWasteDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? wasteType = prefs.getString('wasteType');
    int? weight = prefs.getInt('weight');
    int? estPrice = prefs.getInt('estPrice');
    return {
      'wasteType': wasteType,
      'weight': weight,
      'estPrice': estPrice,
    };
  }

  // Remove waste details
  Future<void> removeWasteDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('wasteType');
    await prefs.remove('weight');
    await prefs.remove('estPrice');
  }
}
