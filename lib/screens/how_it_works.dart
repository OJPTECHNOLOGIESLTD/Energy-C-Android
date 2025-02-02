import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class HowItWorksPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: "How It Works"),
      body: DecoratedBox(position: DecorationPosition.background,
         decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: BackImageScafford.bgImg)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              _buildCardSection(),
              SizedBox(height: 20),
              Text(
                'How It Works',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                       width: MediaQuery.of(context).size.width *0.3,
                      child: _buildStepWidget('1', 'Earn Points',
                          'Every successful request earns you points.'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.3,
                      child: _buildStepWidget('2', 'Convert',
                          'Convert your points to money equivalent.'),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.3,
                      child: _buildStepWidget('3', 'Shop With Points',
                          'Redeem your points for discounts or full payments.'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Rewards Levels',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Level',style: TextStyle( fontWeight: FontWeight.w500),),
                  Text('Point Threshold',style: TextStyle( fontWeight: FontWeight.w500),),
                  Text('1 Point Value (₦ 20)',style: TextStyle( fontWeight: FontWeight.w500),),
                ],
              ),
              SizedBox(height: 16),
              _buildRewardLevel('1','Beginner', 50, 20),
              _buildRewardLevel('2','Hustler', 100, 40),
              _buildRewardLevel('3','Planet Guardian', 200, 60),
              SizedBox(height: MediaQuery.of(context).size.height *0.2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardSection() {
    return Card(
      color: Customcolors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0, top: 16,bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/shopping_bag.png', // Add your image path
              height: 150,
            ),
            SizedBox(height: 10),
            Expanded(
              child: RichText(
                softWrap: true,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(color: Customcolors.white,),
                            children: [
                              TextSpan(
                                text: 'Energy Chleen',
                                style: TextStyle(
                                    color: Customcolors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                            text: ' Rewards system! Recycle with us, earn points, and unlock higher levels for greater shopping value!',
                            style: TextStyle(color: Customcolors.white),
                          )],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepWidget(String number, String title, String description) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: Customcolors.teal,
          child: Text(
            number,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        SizedBox(height: 10),
        Text(
          title,
          style: TextStyle( fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRewardLevel(String level, String levelTitle, int points, int value) {
    return Card(
      color: Customcolors.teal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Level $level',
                style: TextStyle(color: Customcolors.white),),
                Text(
                  levelTitle,
                  style: TextStyle(color: Customcolors.white),
                ),
              ],
            ),
            Text('Points $points',
            style: TextStyle(color: Customcolors.white,),),
            Text('₦ $value',
            style: TextStyle(color: Customcolors.white),),
          ],
        ),
      ),
    );
  }
}
