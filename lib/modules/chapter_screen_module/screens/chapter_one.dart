import 'dart:async';
import 'dart:developer';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/quiz.dart';
import 'package:quizzin_app/modules/home_screen_module/screens/home_screen.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class ChapterOneScreen extends StatefulWidget {
  final int chapterId;
  const ChapterOneScreen({super.key, required this.chapterId});

  @override
  State<ChapterOneScreen> createState() => _ChapterOneScreenState();
}

class _ChapterOneScreenState extends State<ChapterOneScreen> {
  List arrLevels = [];
  String title = '';

  bool timerStarted = false;

  chooseLevel() async {
    print(token);
    final response = await DioClientServices.instance
        .dioPostCall(context, url: chapterLevel, isLoading: true, bodyTag: {
      'chapter_id': widget.chapterId,
    });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      title = response['result']['chapter_levels']['chapter_title'].toString();
      for (int i = 0;
          i < response['result']['chapter_levels']['levelsDetails'].length;
          i++) {
        arrLevels.add(
          response['result']['chapter_levels']['levelsDetails'][i],
        );
      }
      setState(() {});
      print('my list is ${arrLevels}');
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void initState() {
    chooseLevel();
    super.initState();
  }

  void startTimerAndNavigate() {
    const duration = Duration(seconds: 5);
    Timer(duration, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      ).then((_) {
        setState(() {
          timerStarted = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff181632),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: 110,
              color: const Color(0xff232149),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                      color: Color(0xff876DFF),
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Image.asset('assets/images/Ram.png'),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chapter ${widget.chapterId} - Ramayana',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40, right: 30, bottom: 10, top: 30),
              child: arrLevels.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: arrLevels.length,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30,
                                  childAspectRatio: 1),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Color(0xff212349),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 40,
                                              bottom: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'assets/images/Time.png'),
                                              SizedBox(
                                                height: 45,
                                              ),
                                              Text(
                                                'Remember',
                                                style: TextStyle(
                                                    color: Colors.orange[800],
                                                    fontSize: 23,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                textAlign: TextAlign.center,
                                                'You have to give answer of\neach question within 59\nseconds',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              SizedBox(
                                                height: 40,
                                              ),
                                              RoundButton(
                                                title: 'Okay, Start',
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuizScreen(),
                                                      ));
                                                },
                                              ),
                                              SizedBox(
                                                height: 25,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xff232149),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      arrLevels[index]['is_played'] == 0
                                          ? 'Not Played'
                                          : 'Played',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 17),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    AvatarGlow(
                                      animate: ((arrLevels[index]
                                                          ['is_played'] ==
                                                      0 &&
                                                  index == 0) ||
                                              (index > 0 &&
                                                  arrLevels[index - 1]
                                                          ['is_played'] ==
                                                      1 &&
                                                  arrLevels[index]
                                                          ['is_played'] ==
                                                      0))
                                          ? true
                                          : false,
                                      glowShape: BoxShape.circle,
                                      repeat: true,
                                      glowColor: Colors.green.shade900,
                                      child: Container(
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                        child: Center(
                                            child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Level ${index + 1}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
