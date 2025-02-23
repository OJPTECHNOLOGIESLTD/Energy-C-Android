import 'package:energy_chleen/data/auth_controller.dart';
import 'package:energy_chleen/screens/recyclingpage.dart';
import 'package:energy_chleen/screens/wastes/waste_type.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartRecyclingWaste extends StatefulWidget {
  const StartRecyclingWaste({super.key});

  @override
  State<StartRecyclingWaste> createState() => _StartRecyclingWasteState();
}

class _StartRecyclingWasteState extends State<StartRecyclingWaste> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recycle'),
        SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35, // Adjust the height of the PageView to fit content
          child: Obx(() {
            if (authController.wasteDetails.value == null) {
              return ShimmerEffects(height: 0.03);
            } else {
              return PageView.builder(
                itemCount: 3, // Define how many pages you want to display
                itemBuilder: (context, index) {
                  return PageviewItem();
                },
              );
            }
          }),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              print('View All');
              Navigator.push(context, MaterialPageRoute(builder: (context) => WasteTypesPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Customcolors.teal,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                'View All',
                style: TextStyle(color: Customcolors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PageviewItem extends StatelessWidget {
  const PageviewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        color: Customcolors.offwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                authController.wasteDetails.value?.image ?? 'https://via.placeholder.com/150', // Placeholder image URL
                width: MediaQuery.of(context).size.width * 0.4,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/Recycle-bin-green.png', // Path to your local placeholder image
                    width: MediaQuery.of(context).size.width * 0.4,
                  );
                },
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Customcolors.teal,
                  side: BorderSide(
                    color: Customcolors.offwhite, // Border color
                    width: 0, // Border thickness
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  _navigateToRecyclingPage(context);
                },
                child: Text(
                  'Recycle ${authController.wasteDetails.value?.name ?? ''}',
                  style: TextStyle(
                    fontSize: 18, // Adjusts the text size inside the button
                    fontWeight: FontWeight.bold,
                    color: Customcolors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRecyclingPage(BuildContext context) async {
    // Get waste type title strictly from the backend
    final authController = Get.find<AuthController>();

    if (authController.wasteDetails.value != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecyclingPage(
            wasteType: authController.wasteDetails.value!.name,
            actionType1: false,
          ), // Pass waste type title
        ),
      );
      print("Navigating to recycling page with waste type: ${authController.wasteDetails.value!.name}");
    } else {
      print("Error: Waste details not available.");
    }
  }
}
