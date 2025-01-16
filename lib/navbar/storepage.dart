import 'package:energy_chleen/appbars/appbars.dart';
import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            const Text(
              'Waste Recycle Essentials',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const Text(
              'Discover premium waste collection and cleaning tools designed for a cleaner, greener lifestyle. From durable garbage cans to eco-friendly waste bags, protective gloves, and more, we’ve got everything you need to make waste management easy and efficient.',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 50),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.3),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 50),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 4, // Replace with the actual number of items
              itemBuilder: (context, index) {
                return _buildProductCard(
                  context,
                  imageUrl: index % 2 == 0
                      ? 'https://www.toter.com/sites/default/files/styles/product_detail/public/2022-08/Toter_64Gallon_TwoWheelCan_Graystone_25564_Main.png?itok=Whjdi_dx'
                      : 'https://img.freepik.com/free-vector/black-plastic-bag-trash-garbage-rubbish-realistic-template-polyethylene-trashbag-roll-full-waste-tied-sack-with-refuse-isolated-transparent-background_107791-3522.jpg', // Replace with real image URLs
                  title: index % 2 == 0
                      ? 'Eco-Friendly Waste Bag 1 pcs'
                      : 'Mobile Waste Bin 1 pcs',
                  price: index % 2 == 0 ? '₦500' : '₦100,000',
                  rating: 4.5,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(
    BuildContext context, {
    required String imageUrl,
    required String title,
    required String price,
    required double rating,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          size: 14,
                          color: index < rating ? Colors.amber : Colors.grey.shade300,
                        ),
                      ),
                    ),
                    Text(
                  price,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


