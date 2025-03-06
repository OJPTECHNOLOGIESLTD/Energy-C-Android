import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/pickup_details.dart';
import 'package:energy_chleen/screens/request_summary.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecyclingPage extends StatefulWidget {
  final bool actionType1;
  final String wasteType;

  const RecyclingPage(
      {required this.wasteType, super.key, required this.actionType1});

  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  
  // @override
  // void initState() {
  //   super.initState();
  //   // _saveWasteItemName(); // Call the method to save data when the page initializes
  // }

//   Future<void> _saveWasteItemName() async {
//     print('Waste type saved: ${widget.wasteType}');
//     await storageService.saveWasteItem(wasteType: widget.wasteType

// );
  // }


  final StorageService storageService = StorageService();
  CityName? selectedCity;  // Variable to hold selected city
  StateData? selectedState;

  // Save in shared preference
  Future<void> _saveScheduleData() async {
    final authController = Get.find<AuthController>();

    if (authController.wasteDetails.value == null) {
      Get.snackbar(
        "Error",
        "Details not updated.",
        backgroundColor: Customcolors.red,
        colorText: Customcolors.white,
      );
      return;
    }
    print('Waste type saved: ${widget.wasteType}');
    await StorageService().saveWasteItem(wasteType: widget.wasteType);
    final wasteDetails = authController.wasteDetails.value!;
await storageService.saveWasteDetails(
  weight: wasteDetails.weight.toInt(), // Weight in some unit
  estPrice: wasteDetails.weight.toInt() * wasteDetails.price.toInt(), // Estimated price
);



    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PickUpDetailsPage()),
    );

    print(
        'waste ${wasteDetails.name}, weight ${wasteDetails.weight}, est. price ${wasteDetails.weight * wasteDetails.price}');
  }


  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RecycleTipVideo(),
              Obx(() {
                if (authController.wasteDetails.value == null) {
                  return ShimmerEffects(height: 0.5);
                }
                final wasteDetails = authController.wasteDetails.value!;
                return Column(
                  children: [
                    SizedBox(height: 16),

                    // Wrapping this part in SingleChildScrollView
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title and Price Row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.wasteType,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'NGN ${wasteDetails.price}/kg',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),

                              // Description
                              Text(
                                wasteDetails.description!,
                                style: TextStyle(fontSize: 14),
                              ),

                              SizedBox(height: 16),
                              Text(
                                'Tips for Correct Disposal:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              // TipsWidget(wasteType: wasteDetails.description),
                              Text(
  wasteDetails.instructions.join(', '), // Joining with commas
  style: TextStyle(fontSize: 14),
),


                              SizedBox(height: 24),

                              // Weight and Price section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Weight Selector
                                  Column(
                                    children: [
                                      Text(
                                        'Weight/kg',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      _buildWeightSelector(),
                                    ],
                                  ),

                                  // Price Display
                                  Column(
                                    children: [
                                      Text(
                                        'Est. Price',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'NGN ${wasteDetails.weight * wasteDetails.price}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),

                              // Schedule Button
                              if (!widget.actionType1)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      backgroundColor: Customcolors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await _saveScheduleData();
                                    },
                                    child: Text('Schedule',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Customcolors.white)),
                                  ),
                                ),
                              if (widget.actionType1)
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 16),
                                      backgroundColor: Customcolors.teal,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      await _saveScheduleData();
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RequestSummary()),
                                        (route) =>
                                            true, // This removes all previous routes
                                      );
                                    },
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Customcolors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightSelector() {
    final authController = Get.find<AuthController>();

    return Obx(() {
      if (authController.wasteDetails.value == null) {
        return Text('0'); // Display '0' if wasteDetails is null
      }

      final wasteDetails = authController.wasteDetails.value!;

      return Row(
        children: [
          // Minus Button
          GestureDetector(
            onTap: () {
              if (wasteDetails.weight > 1) {
                authController
                    .updateWasteWeight(wasteDetails.weight.toInt() - 1);
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Customcolors.offwhite,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.remove),
            ),
          ),
          SizedBox(width: 16),

          // Weight Display
          Text('${wasteDetails.weight}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(width: 16),

          // Plus Button
          GestureDetector(
            onTap: () {
              authController.updateWasteWeight(wasteDetails.weight.toInt() + 1);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Customcolors.offwhite,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add),
            ),
          ),
        ],
      );
    });
  }
}
