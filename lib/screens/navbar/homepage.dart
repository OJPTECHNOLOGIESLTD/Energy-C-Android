import 'package:energy_chleen/screens/cards/news_and_event_card.dart';
import 'package:energy_chleen/screens/cards/profile_card_info.dart';
import 'package:energy_chleen/screens/start_recycling_waste.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// HomeController for managing state
class HomeController extends GetxController {
  var profileInfo = ''.obs;
  var newsAndEvents = [].obs;
  
  @override
  void onInit() {
    super.onInit();
    // Fetch data when the controller is initialized
    fetchProfileInfo();
    fetchNewsAndEvents();
  }

  void fetchProfileInfo() {
    // Simulate fetching data (You can call an API here)
    profileInfo.value = "User's profile info";
  }

  void fetchNewsAndEvents() {
    // Simulate fetching data (You can call an API here)
    newsAndEvents.value = ["Event 1", "Event 2", "Event 3"];
  }

  // You can add methods to update the data dynamically
}


class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = Get.put(HomeController()); // Initialize controller

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
                  // ProfileCardInfo will be rebuilt when profileInfo changes
                    Obx(() => ProfileCardInfo(profileInfo: homeController.profileInfo.value)),
                    
                  // NewsAndEventCard(titleBool: true,),
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
