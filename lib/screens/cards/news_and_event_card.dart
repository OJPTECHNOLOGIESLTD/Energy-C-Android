import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

// Assuming NewsEvent is already defined in your models.dart
class NewsAndEventCard extends StatelessWidget {
  final String description;
  final String title;
  final String image;
  final bool titleBool; // Pass titleBool from outside

  const NewsAndEventCard({
    super.key,
    required this.titleBool,
    required this.description,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Customcolors.teal,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, // Dynamic title
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description, // Dynamic description
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  image, // Load dynamic image
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
