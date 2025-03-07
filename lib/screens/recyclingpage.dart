import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/screens/pickup_details.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecyclingPage extends StatefulWidget {
  final bool actionType1;
  final String wasteType;
  final double weight; // Initial weight
  final double price;
  final int wasteId;

  const RecyclingPage(
      {required this.wasteType,
      super.key,
      required this.actionType1,
      required this.weight,
      required this.price, required this.wasteId});

  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  double currentWeight = 0.0;
  double estimatedPrice = 0.0;

  @override
  void initState() {
    super.initState();
    currentWeight = widget.weight; // Set initial weight
    _calculateEstimatedPrice();
  }

  // Method to calculate the estimated price
  void _calculateEstimatedPrice() {
    setState(() {
      estimatedPrice = currentWeight * widget.price;
    });
  }

  // Function to handle weight update
  void _updateWeight(double newWeight) {
    setState(() {
      currentWeight = newWeight;
      _calculateEstimatedPrice(); // Update the price whenever weight changes
    });
  }

  void _navigateToNextPage(
      BuildContext context, String wasteItem, double weight, double price, int wasteId) {
    if (widget.actionType1 == false) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PickUpDetailsPage(
                  wasteType: wasteItem,
                  weight: weight,
                  price: price, wasteId: wasteId,
                )),
      );
    } else {
      Navigator.pop(context);
    }
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
                return Column(children: [
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.wasteType,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'NGN ${widget.price}/kg',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        wasteDetails.instructions
                                            .join(', '), // Joining with commas
                                        style: TextStyle(fontSize: 14),
                                      ),
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
                                            'NGN ${widget.price}/kg',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 16),

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
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 8),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  'NGN $estimatedPrice',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 24),
                                      SizedBox(height: 24),

                                      // Schedule Button
                                      if (!widget.actionType1)
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              backgroundColor:
                                                  Customcolors.teal,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              _navigateToNextPage(
                                                  context,
                                                  widget.wasteType,
                                                  currentWeight,
                                                  estimatedPrice,
                                                  widget.wasteId);
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
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 16),
                                              backgroundColor:
                                                  Customcolors.teal,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              _navigateToNextPage(
                                                  context,
                                                  widget.wasteType,
                                                  currentWeight,
                                                  estimatedPrice,
                                                  widget.wasteId);
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
                                    // Rest of your UI stays the same...
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeightSelector() {
    return Row(
      children: [
        // Minus Button
        GestureDetector(
          onTap: () {
            if (currentWeight > 1) {
              _updateWeight(currentWeight - 1);
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
        Text('$currentWeight',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(width: 16),

        // Plus Button
        GestureDetector(
          onTap: () {
            _updateWeight(currentWeight + 1);
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
  }
}
