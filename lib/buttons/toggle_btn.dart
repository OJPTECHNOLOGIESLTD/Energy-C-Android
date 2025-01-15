import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  ToggleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            elevation: 5,
            color: isSelected ? Customcolors.teal : Customcolors.offwhite,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none, // Prevents the stack from clipping children
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.grey.shade300 : Customcolors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Positioned(
                        right: 4,
                        left: 4,
                        bottom: 4,
                        top: 4, // Adjust this if needed to place the CircleAvatar inside the container
                        child: CircleAvatar(
                          backgroundColor: Customcolors.white,
                          radius: 10,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10), // Space between the icon and the text
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Customcolors.white : Customcolors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
