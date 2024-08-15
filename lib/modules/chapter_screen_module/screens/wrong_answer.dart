import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';

class WrongAnswerScreen extends StatefulWidget {
  const WrongAnswerScreen({super.key});

  @override
  State<WrongAnswerScreen> createState() => _WrongAnswerScreenState();
}

class _WrongAnswerScreenState extends State<WrongAnswerScreen> {
  final int maxLength = 100;
  TextEditingController controller = TextEditingController();
  List arrList = [
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report This Question'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff181632),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 30, left: 10, right: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const CircleAvatar(
                        backgroundColor: Color(0xff232149),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xff876DFF),
                        ),
                      ),
                    ),
                    const Text(
                      'Wrong Answers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '3 out of 12',
                      style: TextStyle(color: Colors.red, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 22),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: arrList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35)),
                              child: Card(
                                child: ListTile(
                                  tileColor: const Color(0xff232149),
                                  title: Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.orange.shade900,
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: Center(
                                            child: Text(
                                          arrList[index]['number'],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            arrList[index]['title'],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            arrList[index]['title2'],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Color(0xff876DFF),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      const Divider(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            arrList[index]['your answer'],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            arrList[index]['answer1'],
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            arrList[index]['right answer'],
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            arrList[index]['answer2'],
                                            style: const TextStyle(
                                                color: Colors.green),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Container(
                                                      height: 440,
                                                      width: 200,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Color(
                                                              0xff232149)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                right: 10,
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'Report This Question',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .orange
                                                                      .shade900),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Text(
                                                              'How old was SIta when she married Lord Ram?',
                                                              style: TextStyle(
                                                                  fontSize: 17,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              cursorColor:
                                                                  Colors.white,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              controller:
                                                                  controller,
                                                              minLines: 4,
                                                              maxLines: 7,
                                                              maxLength:
                                                                  maxLength,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'Enter Your Feedback',
                                                                hintStyle: TextStyle(
                                                                    color: Color(
                                                                        0xff876DFF)),
                                                                border:
                                                                    OutlineInputBorder(),
                                                                filled: true,
                                                                fillColor: Color(
                                                                    0xff181632),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),
                                                            RoundButton(
                                                              title: 'Submit',
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              arrList[index]['trail'],
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: RoundButton(
                  title: 'Closed',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
