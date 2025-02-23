import 'dart:convert';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {

static const String baseUrl = "https://backend.energychleen.ng/api";

Future<List<RecycleEssentials>> fetchRecycleEssentials() async {
  try {
    final url = Uri.parse('$baseUrl/recycle-essentials');
    print('Requesting: $url');

    final response = await http.get(url).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      print('items${response.body}');
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) => RecycleEssentials.fromJson(item)).toList();
      } else {
        throw Exception('Invalid response format. Expected JSON.');
      }
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint not found. Check the URL.');
    } else {
      throw Exception('Failed to load recycle-essentials. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Error fetching recycle-essentials: $e');
  }
}

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
              future: fetchRecycleEssentials(),
              // ApiService.instance.fetchRecycleEssentials(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerEffects(height: 0.5);
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
                        '₦ $price',
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
