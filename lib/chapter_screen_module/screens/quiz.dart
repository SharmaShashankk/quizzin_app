import 'package:flutter/material.dart';
import 'package:quizzin_app/authentication_screen_module/widgets/button.dart';
// import 'package:quizzin_app/chapter_screen_module/screens/chapter_one.dart';
import 'package:quizzin_app/chapter_screen_module/screens/result.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _currentTime = 0;
  bool isMuted = false;

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        _currentTime = _controller.value * 60;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Color(0xff876DFF), width: 8),
                    ),
                    child: Center(
                      child: Text(
                        '53',
                        style: TextStyle(
                            color: Color(0xff876DFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  GestureDetector(
                      child: IconButton(
                          onPressed: () {
                            toggleMute();
                          },
                          icon: Icon(
                            isMuted
                                ? Icons.volume_up_rounded
                                : Icons.volume_off_rounded,
                            color: isMuted ? Colors.white : Colors.red,
                            size: isMuted ? 50 : 50,
                          ))),
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
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ChapterOneScreen(),
                                    //     ));
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
