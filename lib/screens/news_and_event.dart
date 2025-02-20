import 'package:energy_chleen/data/api_service.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/cards/news_and_event_card.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:flutter/material.dart';

class NewsAndEvent extends StatelessWidget {
  const NewsAndEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(
        title: 'News and Updates',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<NewsEvent>>(
          future: ApiService.instance.fetchNewsEvents(), // Fetching data
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading spinner
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}')); // Error handling
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No news or events found.')); // No data handling
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final event = snapshot.data![index];
                  final imageUrl = event.images.isNotEmpty
                      ? event.images[0]
                      : 'https://cdn-icons-png.flaticon.com/512/13434/13434972.png'; // Get the first image or fallback
                  
                  return NewsAndEventCard(
                    titleBool: false, 
                    description: event.description, 
                    title: event.title, 
                    image: imageUrl, // Pass the image URL as a string
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

