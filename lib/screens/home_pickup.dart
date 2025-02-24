import 'package:energy_chleen/screens/request_summary.dart';
import 'package:energy_chleen/utils/Helper.dart';
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
  DateTime? _selectedDate;

  // Add lists for cities and states
  final List<String> cities = ['Enugu', 'Lagos', 'Abuja', 'Port Harcourt'];
  final List<String> states = ['Enugu State', 'Lagos State', 'Abuja FCT', 'Rivers State'];

  // Selected city and state variables
  String? _selectedCity;
  String? _selectedState;

  @override
  void dispose() {
    _pickupAddressController.dispose();
    super.dispose();
  }

  Future<void> _savePickupDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString('pickupAddress', _pickupAddressController.text);
      if (_selectedCity != null) {
        await prefs.setString('city', _selectedCity!);
      }
      if (_selectedState != null) {
        await prefs.setString('state', _selectedState!);
      }
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
        _buildDropdown('City/Town', cities, _selectedCity, (value) {
          setState(() {
            _selectedCity = value;
          });
        }),
        _buildDropdown('State', states, _selectedState, (value) {
          setState(() {
            _selectedState = value;
          });
        }),
        Text('Choose Pick Up Date & Time', style: TextStyle(fontWeight: FontWeight.bold)),
        InkWell(
          onTap: () {
            _selectDate(context);
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
                    _selectedCity == null ||
                    _selectedState == null ||
                    _selectedDate == null) {
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

  // Helper to build TextField
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

  // Helper to build Dropdown
  Widget _buildDropdown(String labelText, List<String> items, String? selectedItem, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: selectedItem,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
