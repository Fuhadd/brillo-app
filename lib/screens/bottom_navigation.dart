import 'package:brilloapp/screens/settings_screen.dart';
import 'package:brilloapp/screens/buddies_screen.dart';
import 'package:brilloapp/screens/discover_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'user_profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);
  static const routeName = '/navigation';

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedItemPosition = 2;
  final screens = [
    BuddiesScreen(),
    DiscoverScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SnakeNavigationBar.color(
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.nature_people,
              size: 20,
            ),
            label: 'Buddies',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 20,
              ),
              label: 'Discover'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              size: 20,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 20,
            ),
            label: 'Settings',
          ),
        ],
      ),
      backgroundColor: Colors.grey.withOpacity(0.2),
      body: screens[_selectedItemPosition],
    );
  }
}
