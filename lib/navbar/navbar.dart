import 'package:energy_chleen/Pages/screens/homepage/homepage.dart';
import 'package:energy_chleen/Pages/screens/orderspage.dart';
import 'package:energy_chleen/Pages/screens/profile.dart';
import 'package:energy_chleen/Pages/screens/storepage.dart';
import 'package:energy_chleen/utils/Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int _selectedIndex = 0;

  // List of pages to navigate to when a button is tapped
  final List<Widget> _pages = [
    HomePage(),
    StorePage(),
    OrdersPage(),
    ProfilePage(),
  ];

  // Handle the navigation when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Customcolors.teal : Colors.grey,
        ),
        const SizedBox(height: 4),  // Space between icon and label
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Customcolors.teal : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],  // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,  // Ensures all items are visible
        items: [
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.home, 'Home', 0),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.store, 'Store', 1),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(CupertinoIcons.car_detailed, 'Orders', 2),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _buildNavItem(Icons.person, 'Profile', 3),
            label: '',
          ),
        ],
      ),
    );
  }
}
