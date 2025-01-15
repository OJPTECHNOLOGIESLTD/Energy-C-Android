import 'package:energy_chleen/navbar/navbar.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/reuseable_textformfield.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
  late String email;
  late String password;
  bool isChecked = false;
class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customcolors.teal.withOpacity(0.95),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp, // Your custom icon, you can use any icon you want
            color: Colors.white, // Change the color of the icon
          ),
          onPressed: () {
            Navigator.pop(context); // This will pop the current screen and go back
          },
        ),
        toolbarHeight: 40,
      ),
    body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/img1.jpg',))
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
              color: Customcolors.teal.withOpacity(0.95),
              ),
            ),
          ),
      
          // Centered text content over the image and gradient
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              // width: MediaQuery.of(context).size.width * 0.7,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Create an Account",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Join the movement. Sign up in seconds to start earning real cash!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                
                    // textfield
                        ReuseableTextformfield(
                      topTitle: 'First Name',
                      hintText: 'Your first name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'First name is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      topTitle: 'Last Name',
                      hintText: 'Your last name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      topTitle: 'Enter your email',
                      hintText: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      topTitle: 'Enter your phone number',
                      hintText: '080*******95',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      topTitle: 'Create Password',
                      hintText: 'Password',
                      isPasswordField: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                         SizedBox(height: 40),
                         Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                isChecked = value!;
                            });
                          },
                          side: BorderSide(color: Colors.white), 
                          activeColor: Customcolors.yellow, // Customize the checkbox color
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                text: 'By submitting, you have agreed to our ',
                style: TextStyle(color: Customcolors.white),
                children: [
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: Customcolors.yellow, fontWeight: FontWeight.bold),
                    // You can add a gesture recognizer to handle taps on the Privacy Policy
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextSpan(
                    text: 'Terms of Use.',
                    style: TextStyle(color: Customcolors.yellow, fontWeight: FontWeight.bold),
                    // You can add a gesture recognizer to handle taps on the Terms of Use
                  ),
                ],
                            ),
                          ),
                        ),
                      ],
                    ),
                         SizedBox(height: 40),
                         ElevatedButton(
                           style: ElevatedButton.styleFrom(
                            backgroundColor: Customcolors.offwhite,
                              minimumSize: Size(500, 60), // Adjusts the button size (width, height)
                              side: BorderSide(
                                color: Customcolors.offwhite, // Border color
                                width: 0,           // Border thickness
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Border radius for rounded corners
                              ),
                            ),
                           onPressed: () {
                             // Navigate to homepage here
                             Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomBottomNav()),
                          );
                             print("Sign up now!");
                           },
                           child: Text("SIGN UP",
                           style: TextStyle(
                                fontSize: 18,  // Adjusts the text size inside the button
                                fontWeight: FontWeight.bold,
                                color: Customcolors.black,
                              ),),
                         ),
                        //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                        
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}