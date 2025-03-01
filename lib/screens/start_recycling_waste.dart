import 'package:energy_chleen/data/controllers/auth_controller.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/recyclingpage.dart';
import 'package:energy_chleen/screens/wastes/waste_type.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:energy_chleen/utils/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartRecyclingWaste extends StatefulWidget {
  const StartRecyclingWaste({super.key});

  @override
  State<StartRecyclingWaste> createState() => _StartRecyclingWasteState();
}

class _StartRecyclingWasteState extends State<StartRecyclingWaste> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.fetchWasteItems(); // Fetch waste items when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Recycle'),
        const SizedBox(height: 8),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Obx(() {
            if (authController.wasteItems.isEmpty) {
              return ShimmerEffects(height: 0.3);
            } else {
              return PageView.builder(
                itemCount: 3, // Display all waste items
                itemBuilder: (context, index) {
                  return PageviewItem(wasteItem: authController.wasteItems[index]);
                },
              );
            }
          }
          ),
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
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () {
              print('View All');
              Navigator.push(context, MaterialPageRoute(builder: (context) => WasteTypesPage()));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Customcolors.teal,
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Text(
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
  final WasteItem wasteItem; // Accept a waste item

  const PageviewItem({super.key, required this.wasteItem});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Customcolors.offwhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                wasteItem.image ?? 'https://via.placeholder.com/150',
                width: MediaQuery.of(context).size.width * 0.4,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/Recycle-bin-green.png', // Local placeholder image
                    width: MediaQuery.of(context).size.width * 0.4,
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.5,
              // height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  backgroundColor: Customcolors.teal,
                  side: BorderSide(color: Customcolors.offwhite, width: 0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  _navigateToRecyclingPage(context, wasteItem);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Recycle ${wasteItem.name}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Customcolors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToRecyclingPage(BuildContext context, WasteItem wasteItem) {
    _saveWasteItemName(wasteItem);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecyclingPage(
          wasteType: wasteItem.name,
          actionType1: false,
        ),
      ),
    );
    print("Navigating to recycling page with waste type: ${wasteItem.name}");
  }
}
  Future<void> _saveWasteItemName(WasteItem wasteItem) async {
    print('Waste type saved: ${wasteItem.name}');
    await StorageService().saveWasteItem(wasteType: wasteItem.name

);
  }