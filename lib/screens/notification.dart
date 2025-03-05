import 'package:energy_chleen/data/controllers/api_service.dart';
import 'package:energy_chleen/model/models.dart';
import 'package:energy_chleen/screens/navbar/appbars.dart';
import 'package:energy_chleen/screens/read_notification.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool noNotification = true;
  late Future<List<Message>> messagesFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    messagesFuture = ApiService().fetchMessages();
  }

  void markAsRead(Message message) async {
    try {
      bool success = await apiService.markMessageAsRead(message.id);
      if (success) {
        setState(() {
          message.markAsRead(); // Update UI immediately
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar1(title: "Notifications"),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: BackImageScafford.bgImg)),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<List<Message>>(
              future: messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
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
                        SizedBox(
                          height: 10,
                        ),
                        Text('No Notification Yet...')
                      ],
                    ),
                  );
                }

                final messages = snapshot.data!;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ListTile(
                      title: _buildNotifications(
                          title: msg.senderName,
                          subtitle: msg.message,
                          onTap: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>ReadNotification(title: msg.senderName,
                            onTap: (){
                            markAsRead(msg);  
                            }, subtitle: msg.message,)));
                            
                          },
                          isRead: msg.isRead),
                      // trailing: msg.isRead ==1 ? Icon(Icons.done_all) : Text('Unread'),
                    );
                  },
                );
              },
            ),
          ),

          // ListView.builder(
          //   physics: NeverScrollableScrollPhysics(),
          //   itemBuilder: (BuildContext context, int index) {
          //     return _buildNotifications();
          //   },
          // ),
        ),
      ),
      // ),
    );
  }

  Widget _buildNotifications(
      {required String title,
      required String subtitle,
      required VoidCallback onTap,
      required int isRead}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title),
                  SizedBox(
                    width: 300,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      subtitle,
                    ),
                  )
                ],
              ),
              if (isRead == 1) Icon(Icons.done_all, color: Colors.lightBlueAccent,),
              if (isRead == 0) Text('Unread')
            ],
          ),
        ),
      ),
    );
  }
}
