import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class PickupStations extends StatelessWidget {
    final String pickupState;
    final String pickupAddress;
    final bool isSelectedLocation;
    final VoidCallback onTapLocation;
  const PickupStations({super.key, required this.pickupState, required this.pickupAddress, required this.isSelectedLocation, required this.onTapLocation});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTapLocation,
      child: Card(
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        color: isSelectedLocation ? Customcolors.teal : Customcolors.offwhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isSelectedLocation
                          ? Colors.grey.shade300
                          : Customcolors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Positioned(
                    right: 4,
                    left: 4,
                    bottom: 4,
                    top: 4,
                    child: CircleAvatar(
                      backgroundColor: Customcolors.white,
                      radius: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pickupState,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelectedLocation
                          ? Customcolors.white
                          : Customcolors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    pickupAddress,
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelectedLocation
                          ? Customcolors.white
                          : Customcolors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}