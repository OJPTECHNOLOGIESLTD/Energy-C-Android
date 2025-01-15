import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/pickup_details.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecyclingPage extends StatefulWidget {
  final String wasteType;

  const RecyclingPage({required this.wasteType, super.key});

  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  int weight = 3;
  int pricePerKg = 1250; // TODO: Get from backend

  // save in shared preference
    Future<void> _saveScheduleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wasteType', widget.wasteType);
    await prefs.setInt('weight', weight);
    await prefs.setInt('estPrice', weight * pricePerKg);
    print('waste ${widget.wasteType}, weight ${weight}, est. price ${weight * pricePerKg} ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RecycleTipVideo(),
            SizedBox(height: 16),

            // Main Content Section
            Expanded(
              child: Container(
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
                          'NGN $pricePerKg/kg',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Description
                    TipsWidget(wasteType: widget.wasteType),

                    Spacer(),

                    // Weight and Price section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Weight Selector
                        Column(
                          children: [
                            Text(
                              'Weight/kg',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'NGN ${weight * pricePerKg}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24),

                    // Schedule Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Customcolors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () async {
                          // Handle scheduling logic here

                          // Save the schedule data in SharedPreferences
                           await _saveScheduleData();
                          //  navigate to next screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PickUpDetailsPage()),
                          );
                        },
                        child: Text('Schedule',
                            style: TextStyle(
                                fontSize: 16, color: Customcolors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
            setState(() {
              if (weight > 1) {
                weight--;
              }
            });
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
        Text('$weight',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(width: 16),

        // Plus Button
        GestureDetector(
          onTap: () {
            setState(() {
              weight++;
            });
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
