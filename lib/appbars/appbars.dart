import 'package:energy_chleen/Pages/screens/notification.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const Text(
        'ENERGY CHLEEN',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
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
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Customcolors.teal, // Customcolors.teal can be replaced with this for simplicity
                  child: IconButton(
                    icon: const Icon(Icons.headphones_outlined, color: Colors.white),
                    onPressed: () {
                      // Add notification logic here
                    },
                  ),
                ),
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Customcolors.teal, // Customcolors.teal can be replaced with this for simplicity
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                    onPressed: () {
                      // Add notification logic here
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final String title;


  const CustomAppBar1({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return
      AppBar(
        backgroundColor: Colors.transparent,
        title: Text(title),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Customcolors.teal, // Replace Customcolors.teal with Colors.teal for simplicity
          ),
          child: IconButton(
            tooltip: 'Go back',
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.white, // Replace Customcolors.white with Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );
  }
}