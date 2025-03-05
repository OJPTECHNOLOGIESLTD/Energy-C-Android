import 'package:energy_chleen/screens/home_pickup.dart';
import 'package:energy_chleen/screens/item_confirmation.dart';
import 'package:energy_chleen/screens/wastes/waste_info.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';

class RequestSummary extends StatefulWidget {
  const RequestSummary({super.key});

  @override
  State<RequestSummary> createState() => _RequestSummaryState();
}

class _RequestSummaryState extends State<RequestSummary> {
  String? wasteType;
  int? weight;
  int? estPrice;
  DateTime? pickupDate;
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  List<WasteInfoCard> wasteCards = [];
  bool isLoading = true;

@override
void initState() {
  super.initState();
  _loadPickupDetails(); // Load pickup details
  _loadWasteDetails();  // Load waste details
}

Future<void> _loadPickupDetails() async {
  setState(() {
    isLoading = true; // Start loading
  });

  Map<String, dynamic> pickupDetails = await StorageService().loadPickupDetails();
  print('Pickup Address: ${pickupDetails['pickupAddress']}');
  print('City: ${pickupDetails['city']}');

  setState(() {
    // Update controllers with data from pickupDetails
    _pickupAddressController.text = pickupDetails['pickupAddress'] ?? '';
    _cityController.text = pickupDetails['city'] ?? '';
    _stateController.text = pickupDetails['state'] ?? '';

    isLoading = false; // End loading after data is loaded
  });
}

Future<void> _loadWasteDetails() async {
  setState(() {
    isLoading = true; // Start loading
  });
  Map<String, dynamic> wasteType = await StorageService().loadWasteItem();
  Map<String, dynamic> wasteDetails = await StorageService().loadWasteDetails();

  print('Waste Type: ${wasteType['wasteType']}');
  print('Weight: ${wasteDetails['weight']}');
  print('Estimated Price: ${wasteDetails['estPrice']}');

  setState(() {
    // Add waste card based on waste details
   
    _addWasteCard(
      // wasteDetails['weight'].toString(),
      wasteType['wasteType'] ?? 'Unknown',
      wasteDetails['weight']?.toInt() ?? 0,
      wasteDetails['estPrice']?.toInt() ?? 0,
    );

    isLoading = false; // End loading after waste data is loaded
  });
}

void _addWasteCard(String wasteType, int weight, int estimatedIncome) async{
  setState(() {
    wasteCards.add(WasteInfoCard(
      wasteType: wasteType,
      weight: weight,
      estimatedIncome: estimatedIncome,
      editWasteDetails: () {}, // Placeholder for edit functionality
      removeWasteType: () => _removeWasteType(wasteType),
      pickupDate: pickupDate ?? DateTime.now(), // Replace this with actual pickup date if you have it
    ));
  });
}

void _removeWasteType(String wasteType) {
  // Logic to remove waste type from storage and UI
  setState(() {
    wasteCards.removeWhere((card) => card.wasteType == wasteType);
  });
}

Widget _buildWasteTypeAndDetails() {
  if (isLoading) {
    return Expanded(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  if (wasteCards.isEmpty) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          'No Waste To Recycle',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.6,
    child: ListView.separated(
      itemCount: wasteCards.length,
      itemBuilder: (context, index) => wasteCards[index],
      separatorBuilder: (context, index) => SizedBox(height: 10),
    ),
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: CustomAppBar1(title: 'Request Summary'),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          RecyclingScheduleProgress(isReviewing: true, isCompleted: false, isTakingPhoto: false),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Pickup Address',
                      style: TextStyle(
                          color: Customcolors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePickupDetails(),
                          ),
                        );
                      },
                      child: Text(
                        'Change',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Text(
                  '${_pickupAddressController.text} ${_cityController.text} ${_stateController.text}',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Waste Type',
                style: TextStyle(
                    color: Customcolors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.teal.withOpacity(0.1),
                ),
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                    'Add +',
                    style: TextStyle(
                        color: Customcolors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          _buildWasteTypeAndDetails(),
          if (wasteCards.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemConfirmation(),
                    ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Customcolors.teal,
                ),
                child: Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Customcolors.white),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
}
