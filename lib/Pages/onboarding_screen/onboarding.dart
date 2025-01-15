import 'package:energy_chleen/Pages/onboarding_screen/get_started.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView to navigate through the onboarding screens
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 3;
              });
            },
            children: [
              buildPage(
                color: Customcolors.teal,
                title: "SORT YOUR GARBAGE",
                description:
                    "Organize your waste and unlock the first step to turning your trash into treasure.",
                image: Image.asset('assets/Sort_garbage.png',width: MediaQuery.of(context).size.width * 0.8),
              ),
              buildPage(
                color: Customcolors.teal,
                title: "WE PICK IT UP",
                description: "No stress, No hassle-lets collect your recyclable and handle the heavy lifting.",
                image: Image.asset('assets/truck.png', width: MediaQuery.of(context).size.width * 0.8),
              ),
              buildPage(
                color: Customcolors.teal,
                title: "YOU GET PAID",
                description: "Keep in touch with the latest updates.",
                image: Image.asset('assets/Cash.png',width: MediaQuery.of(context).size.width * 0.7),
              ),
              GetStarted(),
            ],
          ),

          // Conditionally show Skip and SmoothPageIndicator based on the current page
          if (!onLastPage)
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.jumpToPage(4); // Jump to the last page
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Skip",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: _controller,
                        count: 4,
                        effect: SwapEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.white.withOpacity(0.3),
                          dotHeight: 8,
                          dotWidth: 8,
                        ),
                      ),
                      GestureDetector(
  onTap: () {
    if (onLastPage && _controller.page?.toInt() == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    } else {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  },
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      "Next",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    ),
  ),
),
                    ],
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
                ],
              ),
            ),
       ],
      ),
    );
  }

  Widget buildPage({
    required Image image,
    required Color color,
    required String title,
    required String description,
  }) {
    return Container(
      color: color,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                description,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.1,)
            ],
          ),
        ),
      ),
    );
  }

}