import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/pickup_details.dart';
import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/request_summary.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecyclingPage extends StatefulWidget {
  final bool actionType1;
  final String wasteType;

  const RecyclingPage(
      {required this.wasteType, super.key, required this.actionType1});

  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  int weight = 3;
  int pricePerKg = 1250; // TODO: Get from backend

  final StorageService storageService = StorageService();

  // Save in shared preference
  Future<void> _saveScheduleData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wasteType', widget.wasteType);
    await prefs.setInt('weight', weight);
    await prefs.setInt('estPrice', weight * pricePerKg);
    print(
        'waste ${widget.wasteType}, weight ${weight}, est. price ${weight * pricePerKg} ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RecycleTipVideo(),
            SizedBox(height: 16),
            
            // Wrapping this part in SingleChildScrollView
            Expanded(
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
                      
                      SizedBox(height: 24),
                      
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
                      if (!widget.actionType1)
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
                              await _saveScheduleData();
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
                      if (widget.actionType1)
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
                              await _saveScheduleData();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestSummary()),
                                (route) => true, // This removes all previous routes
                              );
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                  fontSize: 16, color: Customcolors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
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
