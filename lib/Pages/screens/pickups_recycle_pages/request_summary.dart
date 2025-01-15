import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/home_pickup.dart';
import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/recyclingpage.dart';
import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/waste_info.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController _pickupAddressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadScheduleData();
  }

  Future<void> _loadScheduleData() async {
    StorageService storageService = StorageService();
    // Load pickup details
    Map<String, dynamic> pickupDetails =
        await storageService.loadPickupDetails();
    setState(() {
      _pickupAddressController.text = pickupDetails['pickupAddress'] ?? '';
      _cityController.text = pickupDetails['city'] ?? '';
      _stateController.text = pickupDetails['state'] ?? '';
      pickupDate = pickupDetails['pickupDate'];
    });

    // Load waste details
    Map<String, dynamic> wasteDetails = await storageService.loadWasteDetails();
    setState(() {
      wasteType = wasteDetails['wasteType'];
      weight = wasteDetails['weight'];
      estPrice = wasteDetails['estPrice'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Summary'),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 50,
          width: 50,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Customcolors.teal,
          ),
          child: IconButton(
            tooltip: 'Go back',
            icon:
                Icon(Icons.arrow_back_ios, size: 18, color: Customcolors.white),
            onPressed: () => Navigator.pop(context), // Navigate back
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RecyclingScheduleProgress(isReviewing: true, isCompleted: false),
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
  debugPrint('Navigating to HomePickupDetails...');
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
                          )),
                    ],
                  ),
                  // this text is for displaying the pickup address
                  Text('${_pickupAddressController.text} ${_cityController.text} ${_stateController.text}')

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
                TextButton(
                  onPressed: () {
                    _showWasteTypeDialog();
                  },
                  child: Text(
                    'Add +',
                    style: TextStyle(
                        color: Customcolors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ), //add a fresh/new wasteType to list that will be recycled
                ),
              ],
            ),
            _buildWasteTypeAndDetails(),
          ],
        ),
      ),
    );
  }

  // waste details
  Widget _buildWasteTypeAndDetails() {
    if (wasteType == null ||
        weight == null ||
        estPrice == null ||
        pickupDate == null) {
      return Center(
          child: CircularProgressIndicator()); // Show loading indicator
    }

    return SizedBox(
      height: 300, // Define a fixed height for the list
      child: ListView.separated(
        itemCount: 1, // You are displaying only one item, so set count to 1
        itemBuilder: (context, index) {
          return WasteInfoCard(
            wasteType: wasteType!,
            weight: weight!,
            estimatedIncome: estPrice!,
            editWasteDetails: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RecyclingPage(wasteType: wasteType.toString(), actionType1: true,),
                ),
              );
            },
            removeWasteType: () async {
              // Remove the waste type from SharedPreferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('wasteType');
              await prefs.remove('weight');
              await prefs.remove('estPrice');
              setState(() {
                wasteType = null;
                weight = null;
                estPrice = null;
              });
            },
            pickupDate: pickupDate!,
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }

  List<WasteInfoCard> wasteCards = [];

  Future<void> _showWasteTypeDialog() async {
    List<String> wasteTypes = [
      'Plastic',
      'Glass',
      'Paper',
      'Metal'
    ]; // Example list of waste types
    String? selectedWasteType;

    // Show the dialog
    selectedWasteType = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Waste Type'),
          content: Container(
            height: 100,
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: wasteTypes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(child: Text(wasteTypes[index])),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecyclingPage(wasteType: wasteTypes[index], actionType1: true, ),
                      ),
                    );
                    // Return the selected waste type
                  },
                );
              },
            ),
          ),
        );
      },
    );

    // If a waste type was selected, add a new WasteInfoCard to the list
    if (selectedWasteType != null) {
      setState(() {
        wasteCards.add(WasteInfoCard(
          wasteType: selectedWasteType.toString(),
          weight: 1,
          estimatedIncome: 2,
          editWasteDetails: () {},
          removeWasteType: () {},
          pickupDate: DateTime(2025),
        )); // Add new WasteInfoCard
      });
    }
  }
}
