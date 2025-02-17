import 'package:energy_chleen/data/dto/auth_service.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/news_and_event.dart';
import 'package:flutter/material.dart';

// Assuming NewsEvent is already defined in your models.dart
class NewsAndEventCard extends StatelessWidget {
  final bool titleBool; // Pass titleBool from outside

  const NewsAndEventCard({
    super.key,
    required this.titleBool,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Conditionally showing the title section
        if (titleBool)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "News & Events",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NewsAndEvent()),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
        FutureBuilder<List<NewsEvent>>(
          future: ApiService.instance.fetchNewsEvents(), // Fetching data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator()); // Loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Error handling
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No news or events found.')); // No data handling
            } else {
              // Displaying the list of events
              return ListView.builder(
                shrinkWrap: true, // Allow ListView inside a Column
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling inside the ListView
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index]; // Get the event data
                  final imageUrl = event.images.isNotEmpty
                      ? event.images[0]
                      : ''; // Get the first image or fallback

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event.title, // Dynamic title
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  event.description, // Dynamic description
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
                            child: imageUrl.isNotEmpty
                                ? Image.network(
                                    imageUrl, // Load dynamic image
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'assets/img1.jpg', // Fallback to local asset if no image URL
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
