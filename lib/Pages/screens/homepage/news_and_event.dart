import 'package:energy_chleen/Pages/screens/homepage/news_and_event_card.dart';
import 'package:energy_chleen/appbars/appbars.dart';
import 'package:flutter/material.dart';

class NewsAndEvent extends StatelessWidget {
  const NewsAndEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: 'News and Updates',),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index){
        return NewsAndEventCard(titleBool: false);
      }),
    );
  }
}