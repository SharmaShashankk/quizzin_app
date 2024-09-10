import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class WrongAnswerScreen extends StatefulWidget {
  final List wrongAnswers;

  const WrongAnswerScreen({super.key, required this.wrongAnswers});

  @override
  State<WrongAnswerScreen> createState() => _WrongAnswerScreenState();
}

class _WrongAnswerScreenState extends State<WrongAnswerScreen> {
  final int maxLength = 100;
  TextEditingController controller = TextEditingController();

  List arrList = [];

  updateFeedbackResult(int questionId, String feedback) async {
    print("hajshhas ${questionId}  ${feedback}");
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: updateResult,
      isLoading: true,
      bodyTag: {
        'question_id': questionId.toString(),
        'feedback': feedback,
      },
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');

      Utils().toastMessage(response['result']['message'].toString());
      // setState(() {
      //   arrList = arrList.map((question) {
      //     if (question['question_id'] == questionId) {
      //       question['feedbackGiven'] = true;
      //     }
      //     return question;
      //   }).toList();
      // });
    } else if (response != null && response['status'] == 0) {
      log('my response is $response');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void initState() {
    log('Shashank${widget.wrongAnswers}');
    arrList = widget.wrongAnswers;
    super.initState();
  }

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
                    Text(
                      '${arrList.length} out of 20',
                      style: const TextStyle(color: Colors.red, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 22),
                  child: ListView.builder(
                    itemCount: arrList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xff232149),
                        child: ExpansionTile(
                          title: Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade900,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Center(
                                    child: Text(
                                  (index + 1).toString(),
                                  style: const TextStyle(color: Colors.white),
                                )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Question',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            arrList[index]['title'],
                                            maxLines: 7,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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
                                  const Text(
                                    'Your Answer',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      arrList[index]['userAnswer'],
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'Right Answer',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      arrList[index]['correctAnswer'],
                                      style:
                                          const TextStyle(color: Colors.green),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            content: Container(
                                              height: 490,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      const Color(0xff232149)),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
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
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .orange.shade900),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      arrList[index]['title'],
                                                      style: const TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    TextFormField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      cursorColor: Colors.white,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                      controller: controller,
                                                      minLines: 4,
                                                      maxLines: 7,
                                                      maxLength: maxLength,
                                                      decoration:
                                                          const InputDecoration(
                                                        hintText:
                                                            'Enter Your Feedback',
                                                        hintStyle: TextStyle(
                                                            color: Color(
                                                                0xff876DFF)),
                                                        border:
                                                            OutlineInputBorder(),
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xff181632),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    RoundButton(
                                                      title: 'Submit',
                                                      onTap: () async {
                                                        int questionId =
                                                            arrList[index]
                                                                ['question_id'];
                                                        String feedback =
                                                            controller.text;
                                                        await updateFeedbackResult(
                                                            questionId,
                                                            feedback);
                                                        controller.clear();
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Cancel',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
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
                                    child: const Text(
                                      'Report This Question',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
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
