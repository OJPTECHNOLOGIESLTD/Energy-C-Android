import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool noNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: "Notifications"),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: BackImageScafford.bgImg)),
        child: noNotification
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        maxRadius: 40,
                        backgroundColor: Customcolors
                            .teal, // Customcolors.teal can be replaced with this for simplicity
                        child: Transform.rotate(
                            angle: 0.5,
                            child: Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 50,
                            ))),
                            SizedBox(height: 10,),
                    Text('No Notification Yet...')
                  ],
                ),
              )
            : SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildNotifications();
                    },
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildNotifications() {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today'),
            Text('You Have successfully completed a recycling schedule')
          ],
        ),
      ),
    );
  }
}
