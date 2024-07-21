import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';

class WrongAnswerScreen extends StatefulWidget {
  const WrongAnswerScreen({super.key});

  @override
  State<WrongAnswerScreen> createState() => _WrongAnswerScreenState();
}

class _WrongAnswerScreenState extends State<WrongAnswerScreen> {
  List arrList = [
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
    {
      'number': '1',
      'title': 'Question',
      'title2': 'How old was Sita when she married\nLord Ram?',
      'your answer': 'Your Answer:',
      'right answer': 'Right Answer:',
      'answer1': '16 Years',
      'answer2': '18 Years',
      'trail': 'Report the Question'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff181632),
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
                      child: CircleAvatar(
                        backgroundColor: Color(0xff232149),
                        child: Icon(
                          Icons.arrow_back,
                          color: Color(0xff876DFF),
                        ),
                      ),
                    ),
                    Text(
                      'Wrong Answers',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: arrList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35)),
                              child: Card(
                                child: ListTile(
                                  tileColor: Color(0xff232149),
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
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            arrList[index]['title'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(
                                            arrList[index]['title2'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.keyboard_arrow_up,
                                        color: Color(0xff876DFF),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Divider(),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            arrList[index]['your answer'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            arrList[index]['answer1'],
                                            style: TextStyle(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            arrList[index]['right answer'],
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            arrList[index]['answer2'],
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            arrList[index]['trail'],
                                            style:
                                                TextStyle(color: Colors.grey),
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
                padding: EdgeInsets.only(left: 20, right: 20),
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
