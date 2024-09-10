import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzin_app/models/provider.dart/splash_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SplashProvider>(context, listen: false)
        .checkLoginStatus(context);
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
                  padding: const EdgeInsets.only(top: 45, right: 40, left: 40),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          const TextSpan(
                              text: 'An App by\n',
                              style: TextStyle(color: Colors.white)),
                          TextSpan(
                              text: 'Popular Social Media Influencer',
                              style: TextStyle(
                                  color: Colors.yellowAccent.shade200,
                                  fontSize: 20)),
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
                const Positioned(
                    top: 300,
                    right: 20,
                    child: Stack(
                      children: [
                        Image(
                          image: AssetImage(
                            'assets/images/manu_container.png',
                          ),
                          height: 300,
                          width: 400,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 125,
                          left: 65,
                          child: SizedBox(
                            height: 50,
                            width: 260,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/#manukahat-2.png')),
                            ),
                          ),
                        ),
                      ],
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
                    right: 150,
                    child: Image.asset(
                        height: 130, 'assets/images/Logo Icon - 512.png')),
                Positioned(
                    top: 640, child: Image.asset('assets/images/Text.png')),
                Positioned(
                    top: 830,
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
