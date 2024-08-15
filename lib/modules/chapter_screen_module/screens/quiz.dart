import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quizzin_app/models/questions.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/result.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class QuizScreen extends StatefulWidget {
  final String level;
  final int chapterId;
  const QuizScreen({super.key, required this.level, required this.chapterId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AudioPlayer audioPlayer;
  late Timer _timer;

  int currentQuestionIndex = 0;
  int selectedOptionIndex = -1;
  bool isOptionSelected = false;
  int? isCorrect;
  bool _isPlaying = true;
  bool isQuestionLoading = true;

  double _percent = 1.0;
  int _timeInSeconds = 59;

  // List<QuizQuestionModel> myQuestionArr = text;

  @override
  void initState() {
    super.initState();
    questionsData();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 59),
    )..repeat();

    audioPlayer = AudioPlayer();
    _playMusic();
    _startTimer();
  }

  void _startTimer() {
    _timeInSeconds = 59;
    _percent = 1;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeInSeconds > 0) {
          _timeInSeconds--;
          _percent = _timeInSeconds / 59;
        } else {
          _timer.cancel();
          moveToNextQuestion();
        }
      });
    });
  }

  void _resetTimer() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _startTimer();
  }

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

  void _stopMusic() {
    audioPlayer.stop();
  }

  void checkAnswer(int index) {
    setState(() {
      selectedOptionIndex = index;
      isOptionSelected = true;
      isCorrect =
          arrQues[currentQuestionIndex]['options'][index]['is_correct'] == 1
              ? 1
              : 0;
    });

    Future.delayed(const Duration(seconds: 1), () {
      moveToNextQuestion();
    });
  }

  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < arrQues.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = -1;
        isOptionSelected = false;
        isCorrect = 1;
        _resetTimer();
      } else {
        _stopMusic();
        resultInfo();
      }
    });
  }

  resultInfo() async {
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: levelResult,
      isLoading: true,
      bodyTag: {
        'difficulty_level': widget.level,
        'earned_coin': 18,
        'total_question': arrQues.length,
        'correct_answer': 18,
        'category': 'Chapter',
        'chapter_id': widget.chapterId,
        'wrong_answer_accuracy': jsonEncode([
          // {"question_id": 1, "user_answer": "Not Answered"},
          // {"question_id": 2, "user_answer": "Not Answered"}
        ]),
      },
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultScreen(),
          ));

      Utils().toastMessage(response['result']['message'].toString());
    } else if (response != null && response['status'] == 0) {
      log('my response is $response');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  List<QuizQuestionModel> arrQues = [];

  questionsData() async {
    isQuestionLoading = true;
    final response = await DioClientServices.instance.dioPostCall(context,
        url: questionBank,
        isLoading: true,
        bodyTag: {
          'chapter_id': 1,
          'difficulty_level': widget.level,
          'question_section': 'Chapter'
        });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      isQuestionLoading = false;

      arrQues.clear();

      for (int i = 0; i < response['result']['question'].length; i++) {
        print('Ram${response['result']['question'][i]['question_id']}');
        arrQues.add(QuizQuestionModel(
            questionId: response['result']['question'][i]['question_id'],
            questionImage:
                response['result']['question'][i]['question_image'] ?? '',
            text: response['result']['question'][i]['text'],
            difficultyLevel: response['result']['question'][i]
                ['difficulty_level'],
            options: response['result']['question'][i]['options'],
            correctAnswer: response['result']['question'][i]['correct_answer'],
            correctAnswerIndex: response['result']['question'][i]
                ['correct_answer_index'],
            quizLevel: response['result']['question'][i]['quiz_level'],
            quizCoin: response['result']['question'][i]['quiz_coin'],
            questionCorrectAccuracy: response['result']['question'][i]
                ['question_correct_accuracy'],
            chapterId: response['result']['question'][i]['chapter_id'],
            isSelected: false));
      }
      setState(() {});
      print('my list is $arrQues');
    } else if (response != null && response['status'] == 0) {
      log('my response is $response');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    audioPlayer.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/Group 250.png'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: isQuestionLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(
                    top: 50, left: 12, right: 10, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      color: Colors.green,
                      value: (currentQuestionIndex + 1) / 20,
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 5,
                            percent: _percent,
                            center: Text(
                              "$_timeInSeconds",
                              style: const TextStyle(
                                  fontSize: 18, color: Color(0xff876DFF)),
                            ),
                            progressColor: const Color(0xff876DFF),
                          ),
                        ),
                        const SizedBox(width: 100),
                        IconButton(
                          onPressed: _toggleMusic,
                          icon: Icon(
                            _isPlaying ? Icons.volume_up : Icons.volume_down,
                            color: _isPlaying ? Colors.green : Colors.red,
                            size: 50,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Question ${currentQuestionIndex + 1} of ${arrQues.length}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 35),
                    Text(
                      arrQues[currentQuestionIndex].text,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 35),
                    SingleChildScrollView(
                      child: Column(children: [
                        ...List.generate(
                          arrQues[currentQuestionIndex].options.length,
                          (index) {
                            return GestureDetector(
                              onTap: () => checkAnswer(index),
                              child: Container(
                                height: 70,
                                width: 400,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: selectedOptionIndex == index
                                      ? (isCorrect == 1
                                          ? Colors.green
                                          : Colors.red)
                                      : const Color(0xff232149),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  arrQues[currentQuestionIndex].options[index]
                                          ['text'] ??
                                      'No answer Available',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            );
                          },
                        )
                      ]),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: const Color(0xff232149),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/images/arrow.png'),
                                      const SizedBox(height: 60),
                                      Text(
                                        'Exit the Quiz?',
                                        style: TextStyle(
                                            color: Colors.orange.shade900,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'If you exit the quiz, your quiz\nprogress will be lost',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      const SizedBox(height: 40),
                                      RoundButton(
                                        title: 'Yes Exit Anyway',
                                        onTap: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
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
                            border: Border.all(color: const Color(0xff232149))),
                        child: const Center(
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

// ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: myQuestionArr.length,
              //   itemBuilder: (context, index) {
              //     return GestureDetector(
              //       onTap: () {
              //         if (myQuestionArr[currentQuestionIndex].isSelected ==
              //             false) {
              //           setState(() {
              //             if (index ==
              //                 myQuestionArr[currentQuestionIndex]
              //                     .correctAnswerIndex) {
              //               myQuestionArr[currentQuestionIndex].options[index]
              //                   ['choose_status'] = 1;
              //               myQuestionArr[currentQuestionIndex].isSelected =
              //                   true;
              //             } else {
              //               myQuestionArr[currentQuestionIndex].options[index]
              //                   ['choose_status'] = 2;
              //               myQuestionArr[currentQuestionIndex].isSelected =
              //                   true;
              //             }
              //           });
              //         }
              //       },
              //       child: AnswerCard(
              //         text: myQuestionArr[currentQuestionIndex].options[index]
              //             ['option'],
              //         chooseStatus: myQuestionArr[currentQuestionIndex]
              //             .options[index]['choose_status'],
              //         isSelected:
              //             myQuestionArr[currentQuestionIndex].isSelected,
              //       ),
              //     );
              //   },
              // ),

              // RoundButton(
              //   title: 'Result Screen',
              //   onTap: () {
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => ResultScreen(),
              //     //     ));
              //   },
              // ),





// API CALL//


  