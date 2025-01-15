import 'package:energy_chleen/Auth/login.dart';
import 'package:energy_chleen/Auth/signup.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/img1.jpg',))
      ),
      child: Stack(
        children: [
          // Full-screen image background
          // Positioned.fill(
          //   child: Image.asset('assets/img1.jpg',),
          // ),
          
          // Gradient overlay to blend with the image
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
              color: Customcolors.teal.withOpacity(0.5),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Customcolors.teal,
                    Customcolors.teal.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
      
          // Centered text content over the image and gradient
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(left: 40, right: 40),
              // width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EXPLORE",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Discover how Energy Chleen makes eco-friendly living simple and rewarding. Let’s transform waste into wealth!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                       ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(350, 60), // Adjusts the button size (width, height)
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2,           // Border thickness
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Border radius for rounded corners
                            ),
                          ),
                          onPressed: () {
                            // Navigate to your main app screen here
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                            print("Start now!");
                          },
                          child: Text(
                            "GET STARTED",
                            style: TextStyle(
                              fontSize: 18,  // Adjusts the text size inside the button
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                                              
                        SizedBox(height: 20,),
                                              
                       ElevatedButton(
                         style: ElevatedButton.styleFrom(
                            minimumSize: Size(350, 60), // Adjusts the button size (width, height)
                            side: BorderSide(
                              color: Colors.white, // Border color
                              width: 2,           // Border thickness
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), // Border radius for rounded corners
                            ),
                          ),
                         onPressed: () {
                           // Navigate to your main app screen here
                           print("login now!");
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                         },
                         child: Text("LOG IN",
                         style: TextStyle(
                              fontSize: 18,  // Adjusts the text size inside the button
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),),
                       ),
                      //  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        
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