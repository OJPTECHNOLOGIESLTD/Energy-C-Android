import 'package:energy_chleen/data/auth_controller.dart';
import 'package:energy_chleen/screens/my_points.dart';
import 'package:energy_chleen/screens/recycle_report.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileCardInfo extends StatefulWidget {
  const ProfileCardInfo({super.key, required String profileInfo});

  @override
  State<ProfileCardInfo> createState() => _ProfileCardInfoState();
}

class _ProfileCardInfoState extends State<ProfileCardInfo> {
  final userController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    // Fetch user data if the user is already logged in
    if (userController.isLoggedIn.value) {
      userController.fetchUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userController.userDetails.value == null) {
        return ShimmerEffects(height: 0.2);
      }
      final user = userController.userDetails.value!;
      final userpoints = userController.progressDetails.value!;
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Customcolors.teal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
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
                            'https://img.freepik.com/premium-vector/man-avatar-profile-picture-isolated-background-avatar-profile-picture-man_1293239-4841.jpg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.firstName} ${user.lastName}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Level ${userpoints.currentLevel}: ${user.level}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildInfoCard(
                        'Waste Recycled',
                        '${user.wasteWeight} kg',
                        Icons.recycling,
                        Customcolors.offwhite,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecycleReportScreen()),
                          );
                        },
                      ),
                      _buildInfoCard(
                        'Points Earned',
                        '${user.points}',
                        Icons.favorite,
                        Customcolors.white,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyPointsPage()),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color, {
    required VoidCallback onTap,
  }) {
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
              style: TextStyle(
                  color: Customcolors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Icon(icon, color: Customcolors.teal, size: 24),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  color: Customcolors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
