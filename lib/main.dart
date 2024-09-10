import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzin_app/firebase_options.dart';
import 'package:quizzin_app/models/provider.dart/login_provider.dart';
import 'package:quizzin_app/models/provider.dart/profile_setup_provider.dart';
import 'package:quizzin_app/models/provider.dart/signup_provider.dart';
import 'package:quizzin_app/models/provider.dart/splash_provider.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/modules/splash_screen_module/screens/splash_screen.dart';
import 'package:quizzin_app/utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  token = await SharedPreference.getStringData(key: 'token') ?? '';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => SignupProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => ProfileSetupProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
