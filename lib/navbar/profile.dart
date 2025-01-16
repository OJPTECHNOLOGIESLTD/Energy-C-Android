import 'package:energy_chleen/Pages/screens/recycle_report.dart';
import 'package:energy_chleen/Pages/screens/waste_type.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 70,
                    child: Icon(
                      size: 70,
                        Icons.person), // Replace with user's image URL
                  ),
                  Positioned(
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                          'https://img.freepik.com/premium-vector/man-avatar-profile-picture-isolated-background-avatar-profile-picture-man_1293239-4841.jpg'), // Placeholder for small avatar
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Benjamin Ezoh',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Level 1: Beginner',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Customcolors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text('Edit Profile',
                style: TextStyle(color: Customcolors.white),),
              ),
              const SizedBox(height: 20),
              _buildListTile(
                context,
                icon: Icons.assignment,
                title: 'Waste Types & Rates',
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>WasteTypesPage()));
                },
              ),
              _buildListTile(
                context,
                icon: Icons.event,
                title: 'News & Events',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RecycleReportScreen()));
                },
              ),
              _buildListTile(
                context,
                icon: Icons.star_rate,
                title: 'Rate App',
                onTap: () {},
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25.0),
                child: _buildListTile(
                  context,
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {},
                ),
              ),
              _buildListTile(
                context,
                icon: Icons.rule,
                title: 'Terms & Conditions',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.delete,
                title: 'Delete Account',
                onTap: () {},
              ),
              _buildListTile(
                context,
                icon: Icons.logout,
                title: 'Log out',
                onTap: () {},
              ),
              const SizedBox(height: 20),
              const Text(
                'Version 2.0',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: Customcolors.teal,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: Icon(icon, color: Customcolors.offwhite),
          title: Text(title, style: const TextStyle(fontSize: 16, color: Customcolors.white)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Customcolors.white,),
          onTap: onTap,
        ),
      ),
    );
  }
}