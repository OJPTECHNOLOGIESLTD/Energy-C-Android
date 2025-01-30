import 'package:energy_chleen/Pages/screens/homepage/news_and_event_card.dart';
import 'package:energy_chleen/Pages/screens/homepage/profile_card_info.dart';
import 'package:energy_chleen/Pages/screens/homepage/start_recycling_waste.dart';
import 'package:energy_chleen/appbars/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: DecoratedBox(position: DecorationPosition.background,
         decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: BackImageScafford.bgImg)),
        child: Stack(
          children:[ SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfileCardInfo(),
                  NewsAndEventCard(titleBool: true,),
                  StartRecyclingWaste(),
                ],
              ),
            ),
          ),]
        ),
      ),
    );
  }
}
