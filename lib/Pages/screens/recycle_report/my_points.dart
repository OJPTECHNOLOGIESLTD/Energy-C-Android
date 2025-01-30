import 'package:energy_chleen/appbars/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class MyPointsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'My Points'),
      body: DecoratedBox(position: DecorationPosition.background,
         decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: BackImageScafford.bgImg)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),             
                // Points Description
                Text(
                  textAlign: TextAlign.center,
                  'Track your rewards and enjoy discounts on\nthe eco-friendly essentials store!',
                  style: TextStyle(
                    fontSize: 16, color: Colors.grey[800],),
                ),
                
                SizedBox(height: 24),
                
                // Total Points Earned Section
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Customcolors.teal,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Points Earned',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '20 ~ ₦200',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: true,
                        onChanged: (bool value) {},
                        activeColor: Colors.white,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    color: Customcolors.offwhite,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Redeem Points',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text('Achievements'),
                  TextButton(onPressed: (){}, child: SizedBox(
                    child: Row(children: [
                      Text('How it works')
                    ],),
                  ))
                ],),
                SizedBox(height: 24),
                // Circular Progress Indicator for Level
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 140,
                        width: 140,
                        child: CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          value: 0.2, // progress percentage (20/50 recycled)
                          strokeWidth: 20,
                          backgroundColor: Customcolors.offwhite,
                          valueColor: AlwaysStoppedAnimation<Color>(Customcolors.teal),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(height: 8),
                          Text(
                            'LEVEL 1\nBEGINNER',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Recycle Needed For Next Level
                Center(
                  child: Text(
                    '20/50 Recycle Needed For The Next Level',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Point Redemption History Section
                Text(
                  'Point Redemption History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                
                SizedBox(height: 16),
                
                // History Card
                Card(
                  color: Customcolors.teal,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eco-friendly plastic Trash can',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '50 ~ ₦1,000',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          '₦4,000',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }}