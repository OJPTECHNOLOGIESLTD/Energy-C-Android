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
      padding: const EdgeInsets.symmetric(vertical: 2.5),
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => _editWasteDetails(context),
                        child: Text('Edit',
                            style: TextStyle(color: Customcolors.white)),
                      ),
                      TextButton(
                        onPressed: removeWasteType,
                        child: Text('Remove',
                            style: TextStyle(color: Customcolors.yellow)),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              _buildDetails('Weight', '$weight Kg'),
              _buildDetails('Estimated Income', '\NGN $estimatedIncome'),
              _buildDetails('Pickup Date', '${pickupDate.toLocal()}'.split(' ')[0]),
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

  // Method to show a dialog for editing weight
  Future<void> showWeightDialog(BuildContext context) async {
    TextEditingController weightController = TextEditingController(text: weight.toString());
    
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Weight'),
          content: TextField(
            controller: weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter new weight'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Save new weight
                final updatedWeight = int.tryParse(weightController.text);
                if (updatedWeight != null) {
                  // Update weight with the new value
                }
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Method to show a date picker for editing the pickup date
  Future<void> showDatePickerDialog(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: pickupDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (newDate != null) {
      // Update pickup date with the selected date
    }
  }

  // Edit waste details
  void _editWasteDetails(BuildContext context) {
    // Show a dialog to select either weight or pickup date for editing
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Waste Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Edit Weight'),
                onTap: () {
                  Navigator.pop(context);
                  showWeightDialog(context);
                },
              ),
              ListTile(
                title: Text('Edit Pickup Date'),
                onTap: () {
                  Navigator.pop(context);
                  showDatePickerDialog(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
