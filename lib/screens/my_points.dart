import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/screens/how_it_works.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPointsPage extends StatefulWidget {
  @override
  State<MyPointsPage> createState() => _MyPointsPageState();
}

class _MyPointsPageState extends State<MyPointsPage> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Fetch user data if the user is already logged in
    if (authController.isLoggedIn.value) {
      authController.fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'My Points'),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: BackImageScafford.bgImg)),
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
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
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
                          Obx(() {
                            // Check if the user is logged in and display user details
                            if (authController.isLoggedIn.value) {
                              return authController.userDetails.value != null
                                  ? Text(
                                      '${authController.userDetails.value!.points} ~ ₦200',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: ShimmerEffects(height: 0.03));
                            } else {
                              return Text(
                                  ''); // return blank if user is not logged in
                            }
                          }),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Achievements'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HowItWorksPage()));
                        },
                        child: SizedBox(
                          child: Row(
                            children: [Text('How it works')],
                          ),
                        ))
                  ],
                ),
                SizedBox(height: 24),
                // Circular Progress Indicator for Level
                Obx(() {
                  if (authController.userDetails.value == null && authController.progressDetails.value != null) {
                    return ShimmerEffects(height: 0.15);
                  }
                  final user = authController.progressDetails.value!;
                  final userpoint = authController.userDetails.value!;
                  return Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                            value: userpoint.points! /
                                user.nextLevelPoints, // progress percentage (20/50 recycled)
                            strokeWidth: 20,
                            backgroundColor: Customcolors.offwhite,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Customcolors.teal),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'LEVEL',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              user.currentLevel,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                SizedBox(height: 24),

                // Recycle Needed For Next Level
               Obx(() {
                    // Check if the user is logged in and display user details
                    if (authController.userDetails.value == null) {
                      return ShimmerEffects(height: 0.03);
                    }
                    final user = authController.progressDetails.value!;
                    final userpoint = authController.userDetails.value!;
                    return Center(
                  child:  Text(
                    textAlign: TextAlign.center,
                      '${userpoint.points}/${user.nextLevelPoints.toString()} Recycle Needed For The Next Level\nNext Level: ${user.nextLevel}',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                ); }),

                SizedBox(height: 24),

                // Point Redemption History Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.left,
                      'Point Redemption History',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Item Purchased',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Points Redeemed',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Balance Paid',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),

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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Text(
                            overflow: TextOverflow.visible,
                            'Eco-friendly plastic Trash can',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Customcolors.white),
                          ),
                        ),
                        Text(
                          '50 ~ ₦1,000',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Customcolors.white),
                        ),
                        Text(
                          '₦4,000',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Customcolors.white),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Customcolors.white,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
