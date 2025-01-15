import 'package:energy_chleen/Pages/screens/homepage/news_and_event.dart';
import 'package:energy_chleen/Pages/screens/homepage/profile_card_info.dart';
import 'package:energy_chleen/Pages/screens/homepage/start_recycling_waste.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('ENERGY CHLEEN',
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        leading: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Image.asset(
            'assets/energy.png',
            width: 100,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              backgroundColor: Customcolors.teal,
              child: IconButton(
                icon: Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileCardInfo(),
            NewsAndEvent(),
            StartRecyclingWaste(),
          ],
        ),
      ),
    );
  }
}
