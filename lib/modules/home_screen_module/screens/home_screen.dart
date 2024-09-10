import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/choose_chapter.dart';
import 'package:quizzin_app/modules/profile_screen_module/screens/profile_setup.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  getUserDetails() async {
    final response = await DioClientServices.instance.dioGetCall(
      context,
      url: getUser,
    );
    if (response != null && response['status'] == 1) {
      log('my response is ${response}');
      profileImage =
          response['result']['data']['user']['profile_picture_url'] ?? '';

      firstName = response['result']['data']['user']['first_name'] ?? '';
      print('firstName: $firstName');
      genderData = response['result']['data']['user']['gender'] ?? '';
      age = response['result']['data']['user']['age'].toString();
      emailAddress = response['result']['data']['user']['email'] ?? '';
      mobileNumber = response['result']['data']['user']['mobile_number'] ?? '';

      if (response['result']['data']['setupprofile_status'] == 0) {
        response['result']['data']['setupprofile_status'];
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileSetupScreen(),
            ));
      }
    } else if (response != null && response['status'] == 0) {
      print('my response is ${response}');
      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 40, right: 10),
              height: 135,
              width: 430,
              decoration: BoxDecoration(
                  color: const Color(0xff232149),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/Group 234.png',
                    height: 80,
                  ),
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: 'Namastey !\n',
                        style:
                            TextStyle(color: Color(0xff807DAB), fontSize: 20)),
                    TextSpan(
                        text: 'Shashank',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))
                  ])),
                  const Spacer(),
                  Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                          border: const Border(
                            left: BorderSide(color: Color(0xff876DFF)),
                            right: BorderSide(color: Color(0xff876DFF)),
                            top: BorderSide(color: Color(0xff876DFF)),
                            bottom: BorderSide(color: Color(0xff876DFF)),
                          ),
                          borderRadius: BorderRadius.circular(35),
                          color: Colors.black),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/images/coin 1.png'),
                          const Text(
                            '0',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Let's Play Quiz",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseChapterScreen(),
                                  ));
                            },
                            child: Container(
                              height: 170,
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xffEB6293),
                                    Color(0xffED8C6C)
                                  ])),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, top: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        border: const Border(
                                            bottom:
                                                BorderSide(color: Colors.white),
                                            left:
                                                BorderSide(color: Colors.white),
                                            right:
                                                BorderSide(color: Colors.white),
                                            top: BorderSide(
                                                color: Colors.white)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Question by',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Chapter',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 250,
                              bottom: 100,
                              child: Image.asset('assets/images/books.png'))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
