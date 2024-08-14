import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/chapter_screen_module/screens/levels.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';
// import 'package:step_progress_indicator/step_progress_indicator.dart';

class ChooseChapterScreen extends StatefulWidget {
  const ChooseChapterScreen({super.key});

  @override
  State<ChooseChapterScreen> createState() => _ChooseChapterScreenState();
}

class _ChooseChapterScreenState extends State<ChooseChapterScreen> {
  List arrGrid = [];
  int gridIndex = 0;
  int chapterId = 0;
  bool isLoading = true;
  chooseChapter() async {
    isLoading = true;
    final response = await DioClientServices.instance
        .dioPostCall(context, url: chapterSection, isLoading: true, bodyTag: {
      'category': 'Chapter',
    });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      for (int i = 0; i < response['result']['chapters'].length; i++) {
        arrGrid.add({
          'position': response['result']['chapters'][i]['chapter_id'],
          'image': response['result']['chapters'][i]['chapters_image'],
          'title': response['result']['chapters'][i]['chapter_number'],
          'subtitle': response['result']['chapters'][i]['chapter_title'],
        });
      }
      setState(() {});
      print('my list is ${arrGrid}');
      isLoading = false;
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void initState() {
    chooseChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 10, bottom: 17),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Color(0xff232149),
                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xff876DFF),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 60,
                        ),
                        const Text(
                          'Choose Chapter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 10),
                      child: SingleChildScrollView(
                        child: arrGrid.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: arrGrid.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            childAspectRatio: 0.800,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 18),
                                    itemBuilder: (context, index) {
                                      // Color color = index == 0
                                      //     ? const Color(0xff232149)
                                      //     : const Color(0xff616161);

                                      return GestureDetector(
                                        onTap: () {
                                          gridIndex = index;
                                          chapterId =
                                              arrGrid[index]['position'];
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            shape: BoxShape.rectangle,
                                            color: gridIndex == index
                                                ? const Color(0xff232149)
                                                : const Color(0xff616161),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 10, right: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor:
                                                          gridIndex == index
                                                              ? const Color(
                                                                  0xff181632)
                                                              : const Color(
                                                                  0xff757575),
                                                      child: Text(
                                                        arrGrid[index]
                                                                ['position']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CircleAvatar(
                                                  radius: 35,
                                                  backgroundImage: NetworkImage(
                                                      arrGrid[index]['image']),
                                                ),
                                                // Stack(
                                                //   children: [
                                                //     Container(
                                                //         decoration: BoxDecoration(
                                                //             borderRadius:
                                                //                 BorderRadius.circular(40),
                                                //             border: Border.all(
                                                //                 color: color = index == 0
                                                //                     ? Colors.green
                                                //                     : Colors.grey,
                                                //                 width: 4)),
                                                //         child: Opacity(
                                                //             opacity: 0.4,
                                                //             child: CircleAvatar(
                                                //               backgroundImage: NetworkImage(
                                                //                   arrGrid[index]['image']),
                                                //             ))),
                                                //     Positioned(
                                                //         top: 30,
                                                //         left: 30,
                                                //         child: Image.asset(
                                                //           'assets/images/lock 1.png',
                                                //           color: color = index == 0
                                                //               ? Colors.transparent
                                                //               : Colors.white,
                                                //         )),
                                                //   ],
                                                // ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  'Chapter' " " +
                                                      arrGrid[index]['title']
                                                          .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  arrGrid[index]['subtitle']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                  RoundButton(
                    title: "Next",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LevelsScreen(chapterId: chapterId),
                          ));
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
