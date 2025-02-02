import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class WasteTypesPage extends StatelessWidget {
  final List<Map<String, String>> metalWaste = [
    {'name': 'Iron', 'price': 'NGN 620/kg', 'image': 'assets/Iron.jpg'},
    {'name': 'Copper', 'price': 'NGN 1,050/kg', 'image': 'assets/Copper.jpg'},
    {
      'name': 'Aluminum Zinc',
      'price': 'NGN 2,000/kg',
      'image': 'assets/Aluminum_zinc.jpg'
    },
    {'name': 'Empty Cans', 'price': 'NGN 1,700/kg', 'image': 'assets/cans.jpg'},
    {
      'name': 'Light Aluminum',
      'price': 'NGN 2,200/kg',
      'image': 'assets/light_aluminum.jpg'
    },
    {
      'name': 'Thick Aluminum',
      'price': 'NGN 1,800/kg',
      'image': 'assets/Aluminum-recycling-.jpg'
    },
    {
      'name': 'Aluminum Wire',
      'price': 'NGN 1,000/kg',
      'image': 'assets/light_aluminum.jpg'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'Waste Types'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Description
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Discover the value of your recyclables! This page lists all the waste types we accept and their current rates',
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Customcolors.teal
                    ),
                    child: Text('METAL WASTE',
                    textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: Customcolors.white)),
                  ),
                  SizedBox(height: 40 ),
                  // Optimized ListView.builder
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: metalWaste.length,
                    itemBuilder: (context, index) {
                      final waste = metalWaste[index];
                      return buildWasteItem(
                        imagePath: waste['image']!,
                        name: waste['name']!,
                        price: waste['price']!,
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  // Paper Waste Section
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: () {},
                    child: Text('PAPER WASTE',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWasteItem(
      {required String imagePath,
      required String name,
      required String price}) {
    return Card(
      child: ListTile(
        leading:
            Image.asset(imagePath, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(name),
        trailing: Text(price),
      ),
    );
  }
}
