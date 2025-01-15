import 'package:energy_chleen/Auth/signup.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/reuseable_textformfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}
  late String email;
  late String password;
  bool isChecked = false;
class _LoginState extends State<Login> {
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
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 80),
                
                    // textfield
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
                      topTitle: 'Enter Your Password',
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
                             // Navigate to your main app screen here
                             print("Sign up now!");
                           },
                           child: Text("LOG IN",
                           style: TextStyle(
                                fontSize: 18,  // Adjusts the text size inside the button
                                fontWeight: FontWeight.bold,
                                color: Customcolors.black,
                              ),),
                         ), 
                         SizedBox(height: 40),
                         RichText(
                           textAlign: TextAlign.center,
                           text: TextSpan(
                                       text: 'Don’t have an account yet? ',
                                       style: TextStyle(color: Customcolors.white),
                                       children: [
                                         TextSpan(
                                           text: 'Sign Up',
                                           style: TextStyle(color: Customcolors.yellow, fontWeight: FontWeight.bold),
                                           // You can add a gesture recognizer to handle taps on the Privacy Policy
                                           recognizer: TapGestureRecognizer()
                                           ..onTap = () {
                                             // Handle tap on Terms of Use
                                             print('sign up');
                                             // Navigate sign up page, etc.
                                             Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => Signup()),
                                            );
                                           },
                                         ),
                                       ],
                           ),
                         ),
              
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