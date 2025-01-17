import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// reuseable colors
class Customcolors {
  Customcolors._();

  static const Color teal = Color.fromRGBO(33, 124, 112, 1);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color yellow = Color.fromRGBO(252, 188, 98, 1);
  static const Color green = Colors.green;
  static const Color red = Colors.red;
  static const Color orange = Colors.orange;
  static const Color offwhite = Color.fromRGBO(231, 227, 198, 1);
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

// recycling waste tips
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
        Text(
            '1. Rinse and Clean: Wash containers to remove residue before recycling.'),
        SizedBox(height: 4),
        Text(
            '2. Check the Type: Look for the recycling symbol and ensure it\'s recyclable.'),
        SizedBox(height: 4),
        Text(
            '3. No Mixed Materials: Avoid placing combined materials in the bin.'),
        SizedBox(height: 4),
        Text('4. Flatten for Space: Crush items to save space in the bin.'),
        SizedBox(height: 4),
        Text(
            '5. Remove Caps: Separate caps, as they are often made from different materials.'),
      ],
    );
  }
}

// recycling tips video
class RecycleTipVideo extends StatelessWidget {
  const RecycleTipVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          color: Colors.grey.shade200,
          child: Center(
              child: Stack(children: [
            Image.asset('assets/vid.jpg'),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0,
              child: IconButton(
                onPressed: () {
                  print('Play Video');
                },
                icon: Stack(children: [
                  Icon(
                    Icons.circle_outlined,
                    size: 80,
                    color: Customcolors.white,
                  ),
                  Positioned(
                    left: 5,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Icon(
                      CupertinoIcons.play_arrow_solid,
                      size: 50,
                      color: Customcolors.white,
                    ),
                  ),
                ]),
              ),
            )
          ])),
        ),
        Positioned(
          left: 20,
          top: 16,
          child: Container(
            width: 40,
            padding: EdgeInsets.only(bottom: 1, left: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// reuseable textform
class ReuseableTextformfield extends StatefulWidget {
  final String topTitle;
  final String hintText;
  final bool isPasswordField;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  const ReuseableTextformfield({
    Key? key,
    required this.topTitle,
    required this.hintText,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged, required this.controller,
  }) : super(key: key);

  @override
  State<ReuseableTextformfield> createState() => _ReuseableTextformfieldState();
}

class _ReuseableTextformfieldState extends State<ReuseableTextformfield> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.topTitle,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Customcolors.white),
          ),
          SizedBox(height: 8),
          TextFormField(
            obscureText: widget.isPasswordField ? _obscurePassword : false,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              filled: true, // To fill the background color
              fillColor: Colors.white, // White background color
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide:
                    BorderSide(color: Colors.white), // White border color
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: widget.isPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? CupertinoIcons.eye_slash
                            : CupertinoIcons.eye,
                        color: Colors.black,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// recycling schedule progress
class RecyclingScheduleProgress extends StatelessWidget {
  final bool isReviewing;
  final bool isCompleted;
  
  const RecyclingScheduleProgress({
    super.key,
    required this.isReviewing,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Customcolors.teal),
                  SizedBox(width: 8),
                  Text(
                    '- - - - - - - - - - - - -',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Customcolors.teal,
                    ),
                  ),
                  Icon(Icons.edit, color: isReviewing ? Customcolors.teal : Colors.grey),
                  Text(
                    '- - - - - - - - - - - - -',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Customcolors.teal,
                    ),
                  ),
                ],
              ),
              Icon(Icons.check_circle, color: isCompleted ? Customcolors.teal : Colors.grey),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

