import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class ReadNotification extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const ReadNotification({super.key, required this.title, required this.onTap, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(title,
                style: TextStyle(fontSize: 24,
                fontWeight: FontWeight.bold),),
                Text(subtitle,
                style: TextStyle(fontSize: 18),),
              ],
            ),
        
            GestureDetector(
              onTap: () {
                onTap;
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Customcolors.teal,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'Close',
                style: TextStyle(color: Colors.white,
                fontSize: 24),),
              ),
            )
          ],
        ),
      ),
    );
  }
}