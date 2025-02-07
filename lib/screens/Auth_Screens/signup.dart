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

  // uncomment if need be
  // File? _profilePicture; // Profile picture file
  // final picker = ImagePicker();

  // // Method to pick image from gallery
  // Future<void> _pickImageFromGallery() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _profilePicture = File(pickedFile.path);
  //     });
  //   }
  // }

  // // Method to pick image from camera
  // Future<void> _pickImageFromCamera() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.camera);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _profilePicture = File(pickedFile.path);
  //     });
  //   }
  // }

  // // Registration button handler
  // void _registerUser() {
  //   AuthController.instance.register(
  //     _firstNameController.text,
  //     _lastNameController.text,
  //     _passwordController.text,
  //     _emailController.text,
  //     _phoneController.text,
  //     _profilePicture, // Pass the selected profile picture
  //   );
  // }

  // Form input controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                        if (value == null || value.isEmpty) {
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
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
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
                        if (value == null || value.isEmpty) {
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
                        if (value == null || value.isEmpty) {
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
                        if (value == null || value.isEmpty) {
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
                        minimumSize: Size(
                            500, 60), // Adjusts the button size (width, height)
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
                        if (isChecked == true) {
                          // Navigate to homepage here
                          AuthController.instance.fetchUserDetails();
                          AuthController.instance.register(
                            _firstNameController.text,
                            _lastNameController.text,
                            _passwordController.text,
                            _emailController.text,
                            _phoneController.text
                          );

                          // showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) =>
                          //         _buildProfileImagePopup(context));
                        } else {
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

  // Widget _buildProfileImagePopup(BuildContext context) {
  //   return Dialog(
  //     elevation: 10,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //     backgroundColor: Colors.white,
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             'Please Add a profile photo',
  //             style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.bold,
  //                 color: Colors.black),
  //           ),
  //           SizedBox(height: 20),
  //           GestureDetector(
  //             onTap: () {
  //               _pickImageFromCamera();
  //             },
  //             child: Container(
  //               height: 150,
  //               width: MediaQuery.of(context).size.width,
  //               padding: EdgeInsets.symmetric(horizontal: 0, vertical: 16),
  //               child: Card(
  //                 elevation: 10,
  //                 color: Customcolors.offwhite,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Icon(Icons.camera_alt_outlined,
  //                     size: 50,
  //                     color: Colors.black54,),
  //                     Text('Take A Photo', style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),)
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           // Profile picture preview
  //         if (_profilePicture != null)
  //           Image.file(_profilePicture!, height: 100, width: 100),
  //           SizedBox(height: 30),
  //           if(_profilePicture!=null)
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () => _registerUser(),
  //               style: ElevatedButton.styleFrom(
  //                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 backgroundColor: Colors.teal.shade700,
  //               ),
  //               child: Text('Done',
  //                   style: TextStyle(fontSize: 16, color: Customcolors.white)),
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           SizedBox(
  //             width: double.infinity,
  //             child: ElevatedButton(
  //               onPressed: () => Navigator.pop(context),
  //               style: ElevatedButton.styleFrom(
  //                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 backgroundColor: Colors.teal.shade700,
  //               ),
  //               child: Text('Back',
  //                   style: TextStyle(fontSize: 16, color: Customcolors.white)),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }


}
