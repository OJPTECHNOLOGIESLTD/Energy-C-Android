import 'package:energy_chleen/data/dto/auth_controller.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

bool isChecked = false;

class _SignupState extends State<Signup> {

  // Form input controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
          'assets/img1.jpg',
        ))),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Customcolors.teal.withOpacity(0.95),
                ),
              ),
            ),
            // Centered text content over the image and gradient
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                // width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40),
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
                      controller: _firstNameController,
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
                      controller: _lastNameController,
                      topTitle: 'Last Name',
                      hintText: 'Your last name',
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Last name is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      controller: _emailController,
                      topTitle: 'Enter your email',
                      hintText: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value==null || value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      controller: _phoneController,
                      topTitle: 'Enter your phone number',
                      hintText: '080*******95',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      controller: _passwordController,
                      topTitle: 'Create Password',
                      hintText: 'Password',
                      isPasswordField: true,
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        // Handle change
                      },
                    ),
                    ReuseableTextformfield(
                      controller: _confirmPasswordController,
                      topTitle: 'Confirm Password',
                      hintText: 'Confirm Password',
                      isPasswordField: true,
                      validator: (value) {
                        if (value==null || value.isEmpty) {
                          return 'Confirm Password is required';
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
                          activeColor: Customcolors
                              .yellow, // Customize the checkbox color
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
                                  style: TextStyle(
                                      color: Customcolors.yellow,
                                      fontWeight: FontWeight.bold),
                                  // You can add a gesture recognizer to handle taps on the Privacy Policy
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextSpan(
                                  text: 'Terms of Use.',
                                  style: TextStyle(
                                      color: Customcolors.yellow,
                                      fontWeight: FontWeight.bold),
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
                        minimumSize: Size(500,
                            60), // Adjusts the button size (width, height)
                        side: BorderSide(
                          color: Customcolors.offwhite, // Border color
                          width: 0, // Border thickness
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Border radius for rounded corners
                        ),
                      ),
                      onPressed: () {
                        if (isChecked==true) {
                          // Navigate to homepage here
                          AuthController.instance.register(
                            _firstNameController.text,
                            _lastNameController.text,
                            _passwordController.text,
                            _emailController.text,
                            _phoneController.text);                         
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Customcolors.orange,
                              content: Text(
                                textAlign: TextAlign.center,
                                'you have agreed to our privacy and policy')),
                          );
                        }
                        print("Sign up now!");
                      },
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize:
                              18, // Adjusts the text size inside the button 
                          fontWeight: FontWeight.bold,
                          color: Customcolors.black,
                        ),
                      ),
                    ),
                     SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
