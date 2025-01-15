import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/request_summary.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class HomePickupDetails extends StatefulWidget {
  const HomePickupDetails({super.key});

  @override
  State<HomePickupDetails> createState() => _HomePickupDetailsState();
}

class _HomePickupDetailsState extends State<HomePickupDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField('Pick Up Address',3),
        _buildTextField('City/Town',1),
        _buildTextField('State',1),
        Text('Choose Pick Up Date & Time',
            style: TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            // Open date picker
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Customcolors.teal),
                SizedBox(width: 10),
                Text('Select date',
                    style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Perform your "Next" action here
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RequestSummary()));
                  print("Next button pressed");
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Customcolors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Border radius for rounded corners
                  ),
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Customcolors.white),
                ),
              ),
            ),
          ),
      ],
    );
  }
    Widget _buildTextField(String labelText, int maxLines) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}