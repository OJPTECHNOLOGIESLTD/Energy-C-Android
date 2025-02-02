import 'package:energy_chleen/screens/Auth_Screens/signup.dart';
import 'package:energy_chleen/screens/news_and_event.dart';
import 'package:energy_chleen/screens/my_points.dart';
import 'package:energy_chleen/screens/wastes/waste_type.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: DecoratedBox(position: DecorationPosition.background,
         decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image: BackImageScafford.bgImg)),
          child: SingleChildScrollView(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsAndEvent()));
                  },
                ),
                _buildListTile(
                  context,
                  icon: Icons.star_rate,
                  title: 'Rate App',
                  onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPointsPage()));},
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
                  onTap: () {
                       showDialog(
                context: context,
                builder: (BuildContext context) => _buildDeleteAccountPopup(context)
              );
                  },
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
      ),
    );
  }
  Widget _buildDeleteAccountPopup(BuildContext context) {
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
              'Confirmation Message',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 20),
            _buildWarning(context: context),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.teal.shade700,
                ),
                child: Text('Proceed', style: TextStyle(fontSize: 16, color: Customcolors.white)),
              ),
            ),
            SizedBox(height: 10),
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
                child: Text('Back', style: TextStyle(fontSize: 16, color: Customcolors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarning({
    required BuildContext context,
  }) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Text('Are you sure you want to delete your account?'),
        SizedBox(height: 20,),
        
         Column(
           children: [
            Text('Deleting your account will result in the following:\n\n1. Loss of all your account data.\n2. Inability to recover your account information.'),
        SizedBox(height: 20,),
             RichText(
                  softWrap: true,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.visible,
                            text: TextSpan(
                              text: '⚠ Note: ',
                              style: TextStyle(color: Customcolors.red, fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                  text: 'This action is irreversible, please consider the consequences before proceeding',
                                  style: TextStyle(
                                      color: Customcolors.red,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
           ],
         ),
      ],
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