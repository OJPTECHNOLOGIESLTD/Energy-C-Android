import 'package:energy_chleen/screens/pickups.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class StationPickupDetails extends StatefulWidget {
  const StationPickupDetails({super.key});

  @override
  State<StationPickupDetails> createState() => _StationPickupDetailsState();
}

class _StationPickupDetailsState extends State<StationPickupDetails> {
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
    // More stations
  ];

  @override
  Widget build(BuildContext context) {
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
}