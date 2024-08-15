import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/levels.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/wrong_answer.dart';
import 'package:quizzin_app/modules/chapter_screen_module/widgets/result_card.dart';
import 'package:quizzin_app/modules/chapter_screen_module/widgets/show_custom_dialog.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final controller = ScreenshotController();

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelsScreen(
                            chapterId: 1,
                          ),
                        ));
                  },
                  child: const Icon(
                    Icons.close,
                    size: 40,
                    color: Color(0xff876DFF),
                  ),
                ),
                const SizedBox(
                  width: 120,
                ),
                const Text(
                  'Result',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // resultCard(context),
            Expanded(
              child: Container(
                height: 555,
                width: 420,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CARD-2.png'),
                        fit: BoxFit.cover)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 80,
                                width: 55,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff876DFF)),
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Group 318.png'),
                                        fit: BoxFit.cover)),
                              ),
                              const Image(
                                image:
                                    AssetImage('assets/images/#manukahat.png'),
                                fit: BoxFit.contain,
                                width: 60,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              const CircleAvatar(
                                radius: 35,
                                child: Icon(Icons.person),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: const Color(0xff876DFF))),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/coin 1.png'),
                                      height: 22,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '30',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Image(
                            image: AssetImage('assets/images/Logo Icon-2.png'),
                            height: 70,
                            width: 70,
                            fit: BoxFit.contain,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/images/Great.png'),
                          fit: BoxFit.contain,
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Shashank',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'You earned points',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      Container(
                        height: 80,
                        width: 140,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade900,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image(
                              image: AssetImage('assets/images/coin 1.png'),
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              '30',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'for playing quiz of',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff232149)),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 4),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Chapter 1- Ramayana',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  'Baal kand',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ],
                            ),
                            Image(
                              image: AssetImage('assets/images/Ram.png'),
                              height: 50,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                child: RoundButton(
                  title: 'Share Your Result',
                  onTap: () async {
                    final image = await controller.captureFromWidget(
                      resultCard(context),
                      context: context,
                    );

                    saveAndShare(image);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Your 3 out of 20 answers were correct',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showCustomDialog(context);
                  },
                  child: Container(
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(color: const Color(0xff876DFF))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.orange.shade800,
                            size: 30,
                          ),
                          GradientText('Expand Your Knowledge',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              colors: const [
                                Color(0xff876DFF),
                                Color(0xffFB692A)
                              ]),
                        ],
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WrongAnswerScreen(),
                        ));
                  },
                  child: Container(
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(color: const Color(0xff876DFF))),
                      child: Center(
                        child: GradientText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            'Check Wrong Answers',
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                            colors: const [
                              Color(0xff876DFF),
                              Color(0xffFB692A)
                            ]),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future saveAndShare(Uint8List bytes) async {
  final directory = await getApplicationDocumentsDirectory();
  final image = File('${directory.path}/flutter.png');
  image.writeAsBytesSync(bytes);
  await Share.shareFiles([image.path]);
}
