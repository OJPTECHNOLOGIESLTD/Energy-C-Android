import 'package:energy_chleen/screens/home_pickup.dart';
import 'package:energy_chleen/screens/recyclingpage.dart';
import 'package:energy_chleen/screens/wastes/waste_info.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
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
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  List<WasteInfoCard> wasteCards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadScheduleData();
  }

  Future<void> _loadScheduleData() async {
    try {
      StorageService storageService = StorageService();

      // Load pickup details
      Map<String, dynamic> pickupDetails = await storageService.loadPickupDetails();
      Map<String, dynamic> wasteDetails = await storageService.loadWasteDetails();

      setState(() {
        _pickupAddressController.text = pickupDetails['pickupAddress'] ?? '';
        _cityController.text = pickupDetails['city'] ?? '';
        _stateController.text = pickupDetails['state'] ?? '';
        pickupDate = pickupDetails['pickupDate'];

        wasteType = wasteDetails['wasteType'];
        weight = wasteDetails['weight'];
        estPrice = wasteDetails['estPrice'];

        if (wasteType != null && weight != null && estPrice != null) {
          _addWasteCard(wasteType!, weight!, estPrice!);
        }
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error loading data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _addWasteCard(String wasteType, int weight, int estimatedIncome) {
    setState(() {
      wasteCards.add(WasteInfoCard(
        wasteType: wasteType,
        weight: weight,
        estimatedIncome: estimatedIncome,
        editWasteDetails: () {}, // Placeholder for edit functionality
        removeWasteType: () => _removeWasteType(wasteType),
        pickupDate: pickupDate ?? DateTime.now(),
      ));
    });
  }

  Future<void> _removeWasteType(String wasteTypeToRemove) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('wasteType');
    await prefs.remove('weight');
    await prefs.remove('estPrice');

    setState(() {
      wasteCards.removeWhere((card) => card.wasteType == wasteTypeToRemove);
    });
  }

  @override
  void dispose() {
    _pickupAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Widget _buildWasteTypeAndDetails() {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (wasteCards.isEmpty) {
      return Center(
        child: Text(
          'No Waste To Recycle',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.separated(
        itemCount: wasteCards.length,
        itemBuilder: (context, index) => wasteCards[index],
        separatorBuilder: (context, index) => SizedBox(height: 10),
      ),
    );
  }

  Future<void> _showWasteTypeDialog() async {
  List<String> wasteTypes = ['Plastic', 'Glass', 'Paper', 'Metal'];
  String? selectedWasteType;

  // Show the dialog
  selectedWasteType = await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select Waste Type'),
        content: SizedBox(
          height: 100,
          child: ListView.builder(
            itemCount: wasteTypes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Center(child: Text(wasteTypes[index])),
                onTap: () {
                  Navigator.pop(context, wasteTypes[index]); // Return selected waste type
                },
              );
            },
          ),
        ),
      );
    },
  );

  if (selectedWasteType != null) {
    // Add waste card and navigate to RecyclingPage
    setState(() {
      _addWasteCard(selectedWasteType!, 1, 2); // Example data
    });

    // Navigate after updating the state
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingPage(
          wasteType: selectedWasteType!,
          actionType1: true,
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'Request Summary'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RecyclingScheduleProgress(isReviewing: true, isCompleted: false, isTakingPhoto: false,),
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
                      '${_pickupAddressController.text} ${_cityController.text} ${_stateController.text}')
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
                  padding: EdgeInsets.symmetric(horizontal: 10,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.teal.withOpacity(0.1),
                  ),
                  child: TextButton(
                    onPressed: _showWasteTypeDialog,
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
          ],
        ),
      ),
    );
  }
}
