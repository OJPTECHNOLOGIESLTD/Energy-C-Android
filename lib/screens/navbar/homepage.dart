import 'package:energy_chleen/data/api_service.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/cards/news_and_event_card.dart';
import 'package:energy_chleen/screens/cards/profile_card_info.dart';
import 'package:energy_chleen/screens/news_and_event.dart';
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
  final HomeController homeController =
      Get.put(HomeController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: BackImageScafford.bgImg)),
        child: Stack(children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // ProfileCardInfo will be rebuilt when profileInfo changes
                  Obx(() => ProfileCardInfo(
                      profileInfo: homeController.profileInfo.value)),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "News & Events",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewsAndEvent()),
                            );
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ),

                  FutureBuilder<List<NewsEvent>>(
                    future:
                        ApiService.instance.fetchNewsEvents(), // Fetching data
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerEffects(height: 0.15);
                      } else if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Error: ${snapshot.error}')); // Error handling
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(
                            child: Text(
                                'No news or events found.')); // No data handling
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height *
                              0.15, // Constrain height
                          child: ListView.builder(
                            itemCount: 1, // Limit to showing only 1 item
                            itemBuilder: (context, index) {
                              final event = snapshot.data![index];
                              final images = event.images.isNotEmpty
                                  ? event.images[0]
                                  : 'https://cdn-icons-png.flaticon.com/512/13434/13434972.png'; // Get the first image or fallback
                              return NewsAndEventCard(
                                titleBool: true,
                                description: event.description,
                                title: event.title,
                                image: images,
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),

                  StartRecyclingWaste(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
