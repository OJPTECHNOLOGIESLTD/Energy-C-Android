import 'package:energy_chleen/data/dto/auth_service.dart';
import 'package:energy_chleen/screens/request_summary.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart'; // To format the date

class HomePickupDetails extends StatefulWidget {
  const HomePickupDetails({super.key});

  @override
  State<HomePickupDetails> createState() => _HomePickupDetailsState();
}

class _HomePickupDetailsState extends State<HomePickupDetails> {
  final TextEditingController _pickupAddressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _pickupAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    super.dispose();
  }

  Future<void> _savePickupDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString('pickupAddress', _pickupAddressController.text);
      await prefs.setString('city', _cityController.text);
      await prefs.setString('state', _stateController.text);
      if (_selectedDate != null) {
        await prefs.setString('pickupDate', DateFormat('yyyy-MM-dd').format(_selectedDate!));
      }
      print('Details saved in SharedPreferences');
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String? _validateTextField(String value) {
    if (value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField('Pick Up Address', 3, _pickupAddressController),
        _buildTextField('City/Town', 1, _cityController),
        _buildTextField('State', 1, _stateController),
        Text('Choose Pick Up Date & Time', style: TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            _selectDate(context); // Open date picker
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
                Text(
                  _selectedDate == null
                      ? 'Select date'
                      : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_pickupAddressController.text.isEmpty ||
                    _cityController.text.isEmpty ||
                    _stateController.text.isEmpty ||
                    _selectedDate == null) {
                  // Show a message to the user
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all fields and select a date')),
                  );
                  return;
                }

                await _savePickupDetails();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RequestSummary()),
                );
                // ApiService.instance.submitHomePick(
                // _pickupAddressController.text,
                // _cityController.text,
                // _stateController.text,
                // pickupType:'Icon',
                // _selectedDate.toString());
                print("Next button pressed");
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Customcolors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Customcolors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String labelText, int maxLines, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            errorText: _validateTextField(controller.text),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
