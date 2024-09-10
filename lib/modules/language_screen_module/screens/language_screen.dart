// import 'package:quizzin_app/modules/authentication_screen_module/screens/login_screen.dart';
// import 'package:quizzin_app/authentication_screen_module/screens/login_screen.dart';
// import 'package:quizzin_app/authentication_screen_module/screens/login_screen.dart';
// import 'package:quizzin_app/utils/globals.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizzin_app/modules/authentication_screen_module/screens/login_screen.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  bool isChecked = false;
  bool isImageVisible = false;
  int selectedIndex = 0;

  List arrLanguage = [
    {
      'title': 'Hindi -\n हिन्दी',
      'subtitle': 'assets/images/अ.png',
      'color': [const Color(0xffEB6293), const Color(0xffED8C6C)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'hi',
    },
    {
      'title': 'English',
      'subtitle': 'assets/images/English.png',
      'color': [const Color(0xffEB6293), const Color(0xffED8C6C)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'en',
    },
    {
      'title': 'Tamil - तमिल',
      'subtitle': 'assets/images/tamil.png',
      'color': [const Color(0xff8965CF), const Color(0xffFA86D9)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'ta',
    },
    {
      'title': 'Bengali - बंगाली',
      'subtitle': 'assets/images/layer1.png',
      'color': [const Color(0xff65CF8F), const Color(0xff86DEFA)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'bn',
    },
    {
      'title': 'Marathi - मराठी',
      'subtitle': 'assets/images/अ.png',
      'color': [const Color(0xffF0CB6C), const Color(0xffD7DD8F)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'mr',
    },
    {
      'title': 'Telugu - तेलगु',
      'subtitle': 'assets/images/Group-2.png',
      'color': [const Color(0xff8264FA), const Color(0xff7BC4F9)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'te',
    },
    {
      'title': 'Gujarati - गुजराती',
      'subtitle': 'assets/images/Group-3.png',
      'color': [const Color(0xff65A9CF), const Color(0xff7C99FD)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'gu',
    },
    {
      'title': 'kannada - कन्नड़',
      'subtitle': 'assets/images/Group-2.png',
      'color': [const Color(0xff83B254), const Color(0xffB1FA84)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'kn',
    },
    {
      'title': 'odia - उड़िया',
      'subtitle': 'assets/images/odia.png',
      'color': [const Color(0xffA38994), const Color(0xffE0A3A3)],
      'color2': [Colors.grey, Colors.grey],
      'languageCode': 'or',
    },
  ];
  String selectedLanguage = 'en';
  chooseLanguage() async {
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: languageUpdate,
      isLoading: true,
      bodyTag: {'language_code': selectedLanguage},
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');

      Utils().toastMessage(response['result']['message'].toString());
      Navigator.pop(context);
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 30, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose Language',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Don't worry, You can change it later on",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1.4,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 5),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedLanguage = arrLanguage[index]['languageCode'];
                      selectedIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: selectedIndex == index
                                ? arrLanguage[index]['color']
                                : arrLanguage[index]['color2']),
                        shape: BoxShape.rectangle,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12, top: 20, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  arrLanguage[index]['title'].toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                                selectedIndex == index
                                    ? SvgPicture.asset(
                                        'assets/images/check 1.svg')
                                    : SizedBox()
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Image.asset(arrLanguage[index]['subtitle'])
                        ],
                      ),
                    ),
                  );
                },
                itemCount: arrLanguage.length,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: GestureDetector(
                  onTap: () {
                    chooseLanguage();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Container(
                    height: 60,
                    width: 500,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff876DFF), Color(0xffFB692A)]),
                        borderRadius: BorderRadius.circular(35)),
                    child: const Center(
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
