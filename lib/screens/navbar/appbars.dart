import 'package:energy_chleen/screens/notification.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  backgroundColor: Customcolors
                      .teal, // Customcolors.teal can be replaced with this for simplicity
                  child: IconButton(
                    icon: const Icon(Icons.headphones_outlined,
                        color: Colors.white),
                    onPressed: () {
                      // Add customer logic here
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              _buildCustomerCarePopup(context));
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Customcolors
                      .teal, // Customcolors.teal can be replaced with this for simplicity
                  child: IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.white),
                    onPressed: () {
                      // Add notification logic here
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notifications()));
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

  Widget _buildCustomerCarePopup(BuildContext context) {
    return Dialog(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Contact Support',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            _buildContactRow(
              icon: Icons.email_outlined,
              label: 'support@energychleen.com',
              context: context,
            ),
            SizedBox(height: 10),
            _buildContactRow(
              icon: Icons.phone_outlined,
              label: '+2347045492591',
              context: context,
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.teal.shade700,
                ),
                child: Text('Back',
                    style: TextStyle(fontSize: 16, color: Customcolors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required BuildContext context,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
        color: Customcolors.offwhite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: label));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Copied to clipboard')),
              );
            },
            child: Icon(Icons.copy, color: Colors.teal),
          ),
        ],
      ),
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
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      centerTitle: true,
      leading: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Customcolors
              .teal, // Replace Customcolors.teal with Colors.teal for simplicity
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
