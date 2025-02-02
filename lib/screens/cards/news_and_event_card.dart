import 'package:energy_chleen/screens/news_and_event.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class NewsAndEventCard extends StatelessWidget {
  final bool titleBool;
  const NewsAndEventCard({super.key, required this.titleBool});

  @override
  Widget build(BuildContext context) {
    return // News & Events section
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: titleBool,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "News & Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsAndEvent()));
                    },
                    icon: Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ),
        SizedBox(height: 8),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                        'Same Weight As Usual, 50% Extra Points!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'From the 2nd of February to the 20th of March, you earn extra 50% on pickup.',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/img1.jpg',
                    height: 100, // Specify height
                    width: 100, // Match width to height
                    fit:
                        BoxFit.cover, // Ensures the image fills the square area
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
