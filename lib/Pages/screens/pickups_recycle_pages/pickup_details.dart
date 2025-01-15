import 'package:energy_chleen/Pages/screens/pickups_recycle_pages/pickups.dart';
import 'package:energy_chleen/buttons/toggle_btn.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class PickUpDetailsPage extends StatefulWidget {
  @override
  _PickUpDetailsPageState createState() => _PickUpDetailsPageState();
}

class _PickUpDetailsPageState extends State<PickUpDetailsPage> {
  int _selectedOption = 1; // 1 for Home Pick Up, 2 for Pick Up Station

  // The station list can be moved outside to minimize rebuild
  final List<Map<String, dynamic>> stations = [
    {
      'pickupState': 'Onitsha',
      'pickupAddress': 'No 28 upper iweka',
      'isSelectedLocation': true,
    },
    {
      'pickupState': 'lagos',
      'pickupAddress': '5678 orchid road',
      'isSelectedLocation': false,
    },
    {
      'pickupState': 'lagos',
      'pickupAddress': '5678 orchid road',
      'isSelectedLocation': false,
    },
    // More stations
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Up Details'),
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          height: 50,
          width: 50,
          padding: EdgeInsets.all(5),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Customcolors.teal),
          child: IconButton(
            tooltip: 'Go back',
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Customcolors.white,
            ),
            onPressed: () => Navigator.pop(context), // Navigate back
          ),
        ),
        // backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Icon Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Customcolors.teal),
                      SizedBox(width: 8),
                      Text('- - - - - - - - - - - - - - -',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Customcolors.teal)),
                      Icon(Icons.edit, color: Colors.grey),
                      Text('- - - - - - - - - - - - - - -',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Customcolors.teal)),
                    ],
                  ),
                  Icon(Icons.check_circle, color: Colors.grey),
                ],
              ),
              SizedBox(height: 50),

              // Toggle buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ToggleButton(
                    text: 'Home Pick Up',
                    isSelected: _selectedOption == 1,
                    onTap: () {
                      setState(() {
                        _selectedOption = 1;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  ToggleButton(
                    text: 'Pick Up Station',
                    isSelected: _selectedOption == 2,
                    onTap: () {
                      setState(() {
                        _selectedOption = 2;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 80),

              // Use AnimatedSwitcher for smooth transition
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _selectedOption == 1
                    ? _buildHomePickUpDetails()
                    : _buildPickUpStationDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Home Pick Up details
  Widget _buildHomePickUpDetails() {
    return Column(
      children: [
        _buildTextField('Pick Up Address'),
        _buildTextField('City/Town'),
        _buildTextField('State'),
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
      ],
    );
  }

  // Pick Up Station details
  Widget _buildPickUpStationDetails() {
    // Check if any station is selected
    final isStationSelected =
        stations.any((station) => station['isSelectedLocation']);

    return Column(
      children: [
        // Station list
        SizedBox(
          height: 300, // Define a fixed height for the list
          child: ListView.separated(
            itemCount: stations.length,
            itemBuilder: (context, index) {
              final station = stations[index];
              return PickupStations(
                pickupState: station['pickupState'],
                pickupAddress: station['pickupAddress'],
                isSelectedLocation: station['isSelectedLocation'],
                onTapLocation: () {
                  setState(() {
                    for (var i = 0; i < stations.length; i++) {
                      stations[i]['isSelectedLocation'] = i == index;
                    }
                  });
                },
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        ),

        // Conditionally render the "Next" button
        if (isStationSelected)
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Perform your "Next" action here
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

  Widget _buildTextField(String labelText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
