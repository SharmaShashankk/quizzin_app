import 'package:flutter/material.dart';
import 'package:quizzin_app/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen> {
  SplashServices _splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    _splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Image.asset('assets/images/Design.png'),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 40, left: 40),
                  child: Container(
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(children: [
                          TextSpan(text: 'An App by\n'),
                          TextSpan(
                              text: 'Popular Social Media Influencer',
                              style: TextStyle(
                                  color: Colors.yellow, fontSize: 20)),
                        ])),
                  ),
                ),
                Positioned(child: Image.asset('assets/images/stack_image.png')),
                Positioned(child: Image.asset('assets/images/Ellipse 118.png')),
                Positioned(
                  top: 80,
                  child: Image.asset('assets/images/mannu.png'),
                ),
                Positioned(
                  top: 420,
                  child: Container(
                    child: Image.asset('assets/images/bg.png'),
                  ),
                ),
                Positioned(
                    top: 420,
                    right: 120,
                    child: Container(
                      alignment: Alignment.center,
                      height: 70,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: const Text(
                        '#manukahat',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff181632)),
                      ),
                    )),
                Positioned(
                  top: 160,
                  child: Image.asset('assets/images/star.png'),
                ),
                Positioned(
                  top: 450,
                  right: 60,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    width: 300,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/Rectangle 113.png'))),
                    child: const Text(
                      textAlign: TextAlign.center,
                      '500k+\nFollowers',
                    ),
                  ),
                ),
                Positioned(
                    top: 570,
                    right: 165,
                    child: Image.asset(
                        height: 90, 'assets/images/Logo Icon - 512.png')),
                Positioned(
                    top: 600, child: Image.asset('assets/images/Text.png')),
                Positioned(
                    top: 820,
                    right: 40,
                    child: Image.asset('assets/images/Group 257.png'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
