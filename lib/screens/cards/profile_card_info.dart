import 'package:energy_chleen/data/dto/auth_controller.dart';
import 'package:energy_chleen/screens/my_points.dart';
import 'package:energy_chleen/screens/recycle_report.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class ProfileCardInfo extends StatefulWidget {
  const ProfileCardInfo({super.key, required String profileInfo});

  @override
  State<ProfileCardInfo> createState() => _ProfileCardInfoState();
}

class _ProfileCardInfoState extends State<ProfileCardInfo> {
  @override
  Widget build(BuildContext context) {
    return   // User info card
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                color: Customcolors.teal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                        'https://img.freepik.com/premium-vector/man-avatar-profile-picture-isolated-background-avatar-profile-picture-man_1293239-4841.jpg'), // Placeholder for small avatar
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${AuthController.instance.firstName.value} ${AuthController.instance.lastName.value}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Level 1: Beginner',
                                  style: TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildInfoCard('Waste Recycled', '18 kg', Icons.recycling, Customcolors.offwhite,
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>RecycleReportScreen()));}),
                            _buildInfoCard('Points Earned', '10', Icons.favorite, Customcolors.white,
                            onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPointsPage()));}
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }

    Widget _buildInfoCard(String title, String value, IconData icon, Color color, {required VoidCallback onTap,} ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(color: Customcolors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Icon(icon, color: Customcolors.teal, size: 24),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  color: Customcolors.black, fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}