import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class WasteInfo extends StatelessWidget {
  final String wasteType;
  final int weight;
  final int estimatedIncome;
  final VoidCallback editWasteDetails;
  final VoidCallback removeWasteType;
  final DateTime pickupDate;

  const WasteInfo(
    this.wasteType,
    this.weight,
    this.estimatedIncome,
    this.editWasteDetails,
    this.removeWasteType,
    this.pickupDate, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      color: Customcolors.teal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      wasteType,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Customcolors.black,
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: editWasteDetails,
                            child: Text('Edit'),
                          ),
                          TextButton(
                            onPressed: removeWasteType,
                            child: Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                _buildDetails('Weight', '$weight Kg'),
                _buildDetails('Estimated Income', '\$$estimatedIncome'),
                _buildDetails('Pickup Date', '${pickupDate.toLocal()}'.split(' ')[0]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetails(String leadingText, String endText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leadingText, style: TextStyle(fontWeight: FontWeight.w500)),
        Text(endText, style: TextStyle(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
