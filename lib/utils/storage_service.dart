// services/storage_service.dart

import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Save pickup details
  Future<void> savePickupDetails({
    required String pickupAddress,
    required String city,
    required String state,
    required String pickupOption,
    required DateTime pickupDate,
    required int cityId,
    required int stateId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('pickupAddress', pickupAddress);
    await prefs.setString('city', city);
    await prefs.setString('state', state);
    await prefs.setString('pickupOption', pickupOption);
    await prefs.setString('pickupDate', pickupDate.toIso8601String());
    await prefs.setInt('cityId', cityId); // Corrected key
    await prefs.setInt('stateId', stateId);
  }


  // Load pickup details
  Future<Map<String, dynamic>> loadPickupDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pickupAddress = prefs.getString('pickupAddress');
    String? city = prefs.getString('city');
    String? state = prefs.getString('state');
    String? pickupOption = prefs.getString('pickupOption');
    String? pickupDateStr = prefs.getString('pickupDate'); //pickupOption
    // String? pickupDate;
    // if (pickupDateStr != null) {
    //   pickupDate = DateTime.parse(pickupDateStr);
    // }
     int? cityId = prefs.getInt('cityId');
    int? stateId = prefs.getInt('stateId');
    return {
      'pickupAddress': pickupAddress,
      'city': city,
      'state': state,
      'pickupOption':pickupOption,
      'pickupDate': pickupDateStr,
      'cityId':cityId,
      'stateId':stateId,
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
    double? weight = prefs.getInt('weight')?.toDouble();
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
