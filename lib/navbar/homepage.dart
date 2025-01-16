import 'package:energy_chleen/Pages/screens/homepage/news_and_event.dart';
import 'package:energy_chleen/Pages/screens/homepage/profile_card_info.dart';
import 'package:energy_chleen/Pages/screens/homepage/start_recycling_waste.dart';
import 'package:energy_chleen/appbars/appbars.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
