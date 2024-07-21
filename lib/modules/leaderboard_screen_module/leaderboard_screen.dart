import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class LeaderBoardScreen extends StatefulWidget {
  const LeaderBoardScreen({super.key});

  @override
  State<LeaderBoardScreen> createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  List arrList = [];
  leaderboardData() async {
    final response = await DioClientServices.instance
        .dioPostCall(context, url: leaderboard, isLoading: true, bodyTag: {
      'category': 'Chapter',
    });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      arrList.clear();
      for (int i = 0; i < response['result']['data'].length; i++) {
        arrList.add({
          'rank': response['result']['data'][i]['position'],
          'image': response['result']['data'][i]['profile_picture_url'],
          'title':
              "${response['result']['data'][i]['first_name']} ${response['result']['data'][i]['last_name']}",
          'subtitle': response['result']['data'][i]['coin_balance']
        });
      }
      print('my list is ${arrList}');
      setState(() {});
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void initState() {
    leaderboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg-3.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: const Color(0xff232149),
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Leaderboard',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: arrList.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(arrList[0]['image'])),
                        Positioned(
                          top: 50,
                          left: 18,
                          child: CircleAvatar(
                            radius: 17,
                            backgroundColor: Colors.orange,
                            child: Text(
                              '1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        height: 35,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff876DFF)),
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/coin 1.png'),
                            Text(
                              arrList[0]['subtitle'].toString(),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        NetworkImage(arrList[1]['image'])),
                                const Positioned(
                                  top: 55,
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Color(0xff876DFF),
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  child: Container(
                                      height: 35,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff876DFF)),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.black),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                              'assets/images/coin 1.png'),
                                          Text(
                                            arrList[1]['subtitle'].toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        AssetImage('assets/images/Ram.png')),
                                Positioned(
                                  top: 55,
                                  left: 20,
                                  child: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: Colors.orange[900],
                                    child: const Text(
                                      '3',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 100,
                                  child: Container(
                                      height: 35,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff876DFF)),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: Colors.black),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                              'assets/images/coin 1.png'),
                                          Text(
                                            arrList[2]['subtitle'].toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    ListView.builder(
                      itemCount: arrList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 100,
                            width: 300,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xff181632),
                              borderRadius: BorderRadius.circular(25),
                              border:
                                  Border.all(color: const Color(0xff876DFF)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                    child: Text(
                                      arrList[index]['rank'].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                arrList[index]['image'] == null
                                    ? CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage('assets/images/Ram.png'),
                                      )
                                    : CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            arrList[index]['image']),
                                      ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        arrList[index]['title'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      arrList[index]['subtitle'].toString() +
                                          " " +
                                          'points',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                // Image.asset(arrList[index]['trailing'])
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
