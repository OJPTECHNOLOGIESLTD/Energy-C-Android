import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/screens/recyclingpage.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WasteTypesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomAppBar1(title: 'Waste Types'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Discover the value of your recyclables! This page lists all the waste types we accept and their current rates.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
            SizedBox(height: 40),
            
            // Metal Waste Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildWasteTypeContainer(context: context, title: 'METAL WASTE'),
                  SizedBox(height: 40),

                  Obx(() {
                    if (authController.wasteItems.isEmpty) {
                      return ShimmerEffects(height: 0.3);
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: authController.wasteItems.length,
                        itemBuilder: (context, index) {
                          final waste = authController.wasteItems[index];
                          return buildWasteItem(context: context, wasteItem: waste);
                        },
                      );
                    }
                  }),

                  SizedBox(height: 16),
                  _buildWasteTypeContainer(context: context, title: 'PAPER WASTE'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWasteItem({required BuildContext context, required WasteItem wasteItem}) {
    return GestureDetector(
      onTap: () {
        _navigateToRecyclingPage(context, wasteItem);
      },
      child: Card(
        child: ListTile(
          leading: Image.network(
  wasteItem.image.isNotEmpty ? wasteItem.image[0] : 'https://via.placeholder.com/150',  // Extracting the first image URL if available
  width: 50,
  height: 50,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    return SizedBox(
      width: 50,
      child: Image.asset(
        'assets/Recycle-bin-green.png',  // Local placeholder image
        width: MediaQuery.of(context).size.width * 0.4,
      ),
    );
  },
),

          title: Text(wasteItem.name),
          trailing: Text(wasteItem.price.toString()),
        ),
      ),
    );
  }

  Widget _buildWasteTypeContainer({required BuildContext context, required String title}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Customcolors.teal,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, color: Customcolors.white),
      ),
    );
  }

  void _navigateToRecyclingPage(BuildContext context, WasteItem wasteItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingPage(
          wasteType: wasteItem.name,
          actionType1: false,
        ),
      ),
    );
  }
}
