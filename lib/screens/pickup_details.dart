import 'package:energy_chleen/screens/home_pickup.dart';
import 'package:energy_chleen/screens/station_pickup.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/buttons/toggle_btn.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class PickUpDetailsPage extends StatefulWidget {
  @override
  _PickUpDetailsPageState createState() => _PickUpDetailsPageState();
}

class _PickUpDetailsPageState extends State<PickUpDetailsPage> {
  int _selectedOption = 1; // 1 for Home Pick Up, 2 for Pick Up Station

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'Pick Up Details'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Icon Row
              RecyclingScheduleProgress(
                isReviewing: false,
                isCompleted: false, isTakingPhoto: false,
              ),

              // Toggle buttons
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
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
              ),
              SizedBox(height: 80),

              // Use AnimatedSwitcher for smooth transition
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _selectedOption == 1
                    ? HomePickupDetails()
                    : StationPickupDetails(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
