import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class WasteInfoCard extends StatelessWidget {
  final String wasteType;
  final int weight;
  final int estimatedIncome;
  final VoidCallback editWasteDetails;
  final VoidCallback removeWasteType;
  final DateTime pickupDate;

  const WasteInfoCard({
    super.key,
    required this.wasteType,
    required this.weight,
    required this.estimatedIncome,
    required this.editWasteDetails,
    required this.removeWasteType,
    required this.pickupDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        color: Customcolors.teal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Customcolors.offwhite,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        wasteType,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Customcolors.black,
                        ),
                        overflow: TextOverflow.ellipsis, // Handle long text
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: editWasteDetails,
                        child: Text('Edit',
                        style: TextStyle(color: Customcolors.white),),
                      ),
                      TextButton(
                        onPressed: removeWasteType,
                        child: Text('Remove',
                        style: TextStyle(color: Customcolors.yellow),),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              _buildDetails('Weight', '$weight Kg'),
              _buildDetails('Estimated Income', '\NGN $estimatedIncome'),
              _buildDetails('Pickup Date', '${pickupDate.toLocal()}'.split(' ')[0]
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(String leadingText, String endText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingText,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text(
            endText,
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
