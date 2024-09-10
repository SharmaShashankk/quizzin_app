import 'package:flutter/material.dart';
import 'package:quizzin_app/services/splash_services.dart';

class SplashProvider extends ChangeNotifier {
  final SplashServices splashServices = SplashServices();

  void checkLoginStatus(BuildContext context) {
    splashServices.isLogin(context);
  }
}
