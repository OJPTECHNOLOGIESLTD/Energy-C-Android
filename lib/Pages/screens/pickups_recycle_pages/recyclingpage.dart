import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/pickup_details.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class RecyclingPage extends StatefulWidget {
  final String wasteType;

  const RecyclingPage({required this.wasteType, super.key});

  @override
  _RecyclingPageState createState() => _RecyclingPageState();
}

class _RecyclingPageState extends State<RecyclingPage> {
  int weight = 3;
  int pricePerKg = 1250; // TODO: Get from backend

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.grey.shade200,
                  child: Center(child: Text('Image/Video guide')),
                ),
                Positioned(
                  left: 20,
                  top: 16,
                  child: Container(
                    width: 40,
                    padding: EdgeInsets.only(bottom: 1, left: 5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                    Text(
                      'Learn how to recycle ${widget.wasteType} effectively and contribute to a cleaner, greener environment. Proper disposal ensures it is reused or transformed into sustainable materials, reducing pollution and protecting our ecosystems.',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 16),

                    // Tips for Correct Disposal
                    Text(
                      'Tips for Correct Disposal:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    _buildTips(),

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
                        onPressed: () {
                          // Handle scheduling logic here
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

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            '1. Rinse and Clean: Wash containers to remove residue before recycling.'),
        SizedBox(height: 4),
        Text(
            '2. Check the Type: Look for the recycling symbol and ensure it\'s recyclable.'),
        SizedBox(height: 4),
        Text(
            '3. No Mixed Materials: Avoid placing combined materials in the bin.'),
        SizedBox(height: 4),
        Text('4. Flatten for Space: Crush items to save space in the bin.'),
        SizedBox(height: 4),
        Text('5. Remove Caps: Separate caps, as they are often made from different materials.'),
      ],
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
