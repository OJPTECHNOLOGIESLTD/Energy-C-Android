import 'package:flutter/material.dart';

class Customcolors {
  Customcolors._();

  static const Color teal = Color.fromRGBO(33, 124, 112, 1);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color yellow = Color.fromRGBO(252, 188, 98, 1);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color offwhite = Color.fromRGBO(231,227,198, 1);
  static const Color paymentBlue = Color.fromRGBO(30, 90, 132, 1);
  static const LinearGradient gradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
    colors: [
      Colors.blue,
      Colors.cyan,
      Colors.green,
    ],
  );
}


class TipsWidget extends StatelessWidget {
  final String wasteType;

  const TipsWidget({Key? key, required this.wasteType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        Text(
          'Learn how to recycle $wasteType effectively and contribute to a cleaner, greener environment. Proper disposal ensures it is reused or transformed into sustainable materials, reducing pollution and protecting our ecosystems.',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),

        // Tips for Correct Disposal
        Text(
          'Tips for Correct Disposal:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 8),

        // Call to the _buildTips method
        _buildTips(),
      ],
    );
  }

  Widget _buildTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('1. Rinse and Clean: Wash containers to remove residue before recycling.'),
        SizedBox(height: 4),
        Text('2. Check the Type: Look for the recycling symbol and ensure it\'s recyclable.'),
        SizedBox(height: 4),
        Text('3. No Mixed Materials: Avoid placing combined materials in the bin.'),
        SizedBox(height: 4),
        Text('4. Flatten for Space: Crush items to save space in the bin.'),
        SizedBox(height: 4),
        Text('5. Remove Caps: Separate caps, as they are often made from different materials.'),
      ],
    );
  }
}
