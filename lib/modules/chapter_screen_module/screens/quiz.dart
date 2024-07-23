import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/choose_chapter.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/levels.dart';
// import 'package:quizzin_app/chapter_screen_module/screens/chapter_one.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/result.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _currentTime = 0;
  // bool isMuted = false;

  // void toggleMute() {
  //   setState(() {
  //     isMuted = !isMuted;
  //   });
  // }

  @override
  void initState() {
    _startTimer();
    audioPlayer = AudioPlayer();
    _playMusic();
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 59),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        _currentTime = _controller.value * 59;
      });
    });
  }

  double _percent = 1.0;
  int _timeInSeconds = 59;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeInSeconds > 0) {
          _timeInSeconds--;
          _percent = _timeInSeconds / 59;
        } else {
          _timeInSeconds = 59;
          _percent = 1.0;
          _timer.cancel();
          _startTimer();
        }
      });
    });
  }

  late AudioPlayer audioPlayer;
  bool _isPlaying = true;

  void _playMusic() async {
    await audioPlayer.setReleaseMode(ReleaseMode.loop);
    await audioPlayer.play(AssetSource('audio/ramayan.mp3'));
  }

  void _toggleMusic() {
    setState(() {
      if (_isPlaying) {
        audioPlayer.pause();
      } else {
        audioPlayer.resume();
      }
      _isPlaying = !_isPlaying;
    });
  }

  List arrQues = [];
  questionsData() async {
    print(token);
    final response = await DioClientServices.instance.dioPostCall(context,
        url: questionBank,
        isLoading: true,
        bodyTag: {
          'chapter_id': 1,
          'difficulty_level': 'L1',
          'question_section': 'Chapter'
        });
    if (response != null && response['status'] == 1) {
      log('my response is $response');

      for (int i = 0;
          i < response['result']['chapter_levels']['levelsDetails'].length;
          i++) {
        arrQues.add({});
      }
      setState(() {});
      print('my list is ${arrQues}');
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Group 250.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding:
              const EdgeInsets.only(top: 50, left: 12, right: 10, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                size: Size(400, 50),
                painter: TimeLinePainter(currentTime: _currentTime),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                      child: CircularPercentIndicator(
                    radius: 30,
                    lineWidth: 5,
                    percent: _percent,
                    center: Text(
                      "${_timeInSeconds}",
                      style: TextStyle(fontSize: 18, color: Color(0xff876DFF)),
                    ),
                    progressColor: Color(0xff876DFF),
                  )),
                  SizedBox(
                    width: 100,
                  ),
                  GestureDetector(
                      child: IconButton(
                          onPressed: () {
                            // toggleMute();
                            _toggleMusic();
                          },
                          icon: Icon(
                            _isPlaying ? Icons.volume_up : Icons.volume_down,
                            color: _isPlaying ? Colors.green : Colors.red,
                            size: _isPlaying ? 50 : 50,
                          )
                          // Icon(
                          //   isMuted
                          //       ? Icons.volume_up_rounded
                          //       : Icons.volume_off_rounded,
                          //   color: isMuted ? Colors.white : Colors.red,
                          //   size: isMuted ? 50 : 50,
                          // )
                          )),
                ],
              ),
              Text(
                'Question 1 of 20',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Who was the father of\nSage Vishwamitra?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xff232149),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'King Gadhi',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xff232149),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'King Ravana',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xff232149),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'King Janaka',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: 400,
                decoration: BoxDecoration(
                    color: Color(0xff232149),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    'King Dashratha',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                title: 'Result Screen',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(),
                      ));
                },
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Color(0xff232149),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/arrow.png'),
                                SizedBox(
                                  height: 60,
                                ),
                                Text(
                                  'Exit the Quiz?',
                                  style: TextStyle(
                                      color: Colors.orange.shade900,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  'If you exit the quiz,your quiz\nprogress will be lost',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                RoundButton(
                                  title: 'Yes Exit Anyway',
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseChapterScreen(),
                                        ));
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
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
                  height: 65,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xff232149))),
                  child: Center(
                    child: Text(
                      'Exit the Quiz?',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeLinePainter extends CustomPainter {
  final double currentTime;

  TimeLinePainter({required this.currentTime});

  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.green.shade600
      ..strokeWidth = 5.0;

    double lineWidth = size.width * (currentTime / 60.0);

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(lineWidth, size.height / 2),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(TimeLinePainter oldDelegate) {
    return oldDelegate.currentTime != currentTime;
  }
}
