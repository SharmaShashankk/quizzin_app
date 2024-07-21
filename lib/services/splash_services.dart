import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/modules/language_screen_module/screens/language_screen.dart';
import 'package:quizzin_app/utils/globals.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    // final auth = FirebaseAuth.instance;

    // final user = auth.currentUser;

    if (token != '') {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavigationModule(),
            ));
      });
    } else {
      Timer(
        const Duration(seconds: 3),
        () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LanguageScreen(),
              ));
        },
      );
    }
  }
}
