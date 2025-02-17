import 'package:energy_chleen/data/dto/auth_service.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
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
            SizedBox(height: 40),
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
            FutureBuilder<List<RecycleEssentials>>(
              future: ApiService.instance.fetchRecycleEssentials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found.'));
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return _buildProductCard(
                        context,
                        imageUrl: product.images,
                        title: product.title.trim(),
                        price: product.price,
                        rating: product.rating,
                      );
                    },
                  );
                }
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
    return SizedBox(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
  child: Image.network(
    imageUrl,
    height: MediaQuery.of(context).size.height * 0.15,
    width: double.infinity,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) {
      // Provide a fallback image or widget when image fails to load
      return Image.asset(
        'assets/vid.jpg', // Your fallback image
        fit: BoxFit.contain,
      );
    },
  ),
),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                            size: 10,
                            color: index < rating ? Colors.amber : Colors.grey.shade300,
                          ),
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
