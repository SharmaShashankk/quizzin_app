import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quizzin_app/modules/home_screen_module/screens/home_screen.dart';
import 'package:quizzin_app/modules/leaderboard_screen_module/leaderboard_screen.dart';
import 'package:quizzin_app/modules/profile_screen_module/screens/my_profile.dart';

class BottomNavigationModule extends StatefulWidget {
  const BottomNavigationModule({super.key});

  @override
  State<BottomNavigationModule> createState() => _BottomNavigationModuleState();
}

class _BottomNavigationModuleState extends State<BottomNavigationModule> {
  List pages = [
    LeaderBoardScreen(),
    HomeScreen(),
    MyProfileScreen(),
  ];

  int myIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      bottomNavigationBar: CurvedNavigationBar(
        index: myIndex,
        items: [
          CurvedNavigationBarItem(
              child: Image.asset(
                'assets/images/ranking.png',
                height: 30,
                width: 30,
              ),
              label: 'Leaderboard',
              labelStyle: TextStyle(color: Colors.grey[400])),
          CurvedNavigationBarItem(
              child: Image.asset(
                'assets/images/trophy.png',
                height: 30,
                width: 30,
              ),
              label: 'Play Quiz',
              labelStyle: TextStyle(color: Colors.grey[400])),
          CurvedNavigationBarItem(
              child: Image.asset(
                'assets/images/user(1) 1.png',
                height: 30,
                width: 30,
              ),
              label: 'Profile',
              labelStyle: TextStyle(color: Colors.grey[400]))
        ],
        buttonBackgroundColor: Colors.orange[900],
        backgroundColor: const Color(0xff181632),
        color: const Color(0xff876DFF),
        onTap: (value) {
          myIndex = value;
          setState(() {});
        },
      ),
      body: pages[myIndex],
    );
  }
}
