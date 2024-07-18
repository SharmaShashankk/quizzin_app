import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quizzin_app/authentication_screen_module/widgets/button.dart';
// import 'package:quizzin_app/chapter_screen_module/screens/chapter_one.dart';
import 'package:quizzin_app/chapter_screen_module/screens/wrong_answer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff181632),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ChapterOneScreen(),
                    //     ));
                  },
                  child: Icon(
                    Icons.close,
                    size: 40,
                    color: Color(0xff876DFF),
                  ),
                ),
                SizedBox(
                  width: 120,
                ),
                Text(
                  'Result',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 555,
                  width: 420,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/CARD-2.png'),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    height: 80,
                    width: 55,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff876DFF)),
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('assets/images/Group 318.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                    top: 100,
                    left: 10,
                    child: Image(
                      image: AssetImage('assets/images/#manukahat.png'),
                      width: 60,
                    )),
                Positioned(
                    top: 10,
                    left: 165,
                    child: CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.person),
                    )),
                Positioned(
                  top: 85,
                  left: 160,
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Color(0xff876DFF))),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(
                          image: AssetImage('assets/images/coin 1.png'),
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '30',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: 10,
                    left: 335,
                    child: Image(
                      image: AssetImage('assets/images/Logo Icon-2.png'),
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  top: 170,
                  left: 130,
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/Great.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
                Positioned(
                  top: 225,
                  left: 120,
                  child: Column(
                    children: [
                      Text(
                        'Shashank',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(
                        'You earned points',
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 85,
                        width: 140,
                        padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.orange.shade900,
                            borderRadius: BorderRadius.circular(50)),
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/coin 1.png'),
                              height: 40,
                              fit: BoxFit.cover,
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
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'for playing quiz of',
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 425,
                  left: 10,
                  child: Container(
                    height: 80,
                    width: 395,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/Rectangle 112.png'),
                            fit: BoxFit.cover)),
                    child: ListTile(
                      title: Text(
                        'Chapter 1- Ramayana',
                        style: TextStyle(color: Colors.grey),
                      ),
                      subtitle: Text(
                        'Baal kand',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing:
                          Image(image: AssetImage('assets/images/Ram.png')),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: RoundButton(
                title: 'Share Your Result',
                onTap: () {},
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'Your 3 out of 20 answers were correct',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: Container(
                            height: 830,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Color(0xff232149),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                children: [
                                  Text(
                                    'Expand Your Knowledge',
                                    style: TextStyle(
                                      color: Colors.orange.shade900,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    'Follow & Subscribe',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '#manukahat',
                                    style: TextStyle(
                                      color: Colors.green.shade400,
                                      fontSize: 22,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 55,
                                  ),
                                  Container(
                                    height: 340,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/Group 318.png'),
                                            fit: BoxFit.cover)),
                                  ),
                                  Container(
                                    height: 310,
                                    width: 400,
                                    decoration: BoxDecoration(
                                        color: Color(0xff876DFF),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/manu_container.png'),
                                                height: 90,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                              Positioned(
                                                top: 35,
                                                left: 30,
                                                child: Image(
                                                  image: AssetImage(
                                                      'assets/images/#manukahat-2.png'),
                                                  height: 20,
                                                  width: 90,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/images/Youtube.svg',
                                                height: 75,
                                                width: 75,
                                                fit: BoxFit.cover,
                                              ),
                                              SvgPicture.asset(
                                                'assets/images/instagram 3.svg',
                                                height: 75,
                                                width: 75,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'More than 500k Subscribers',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              height: 60,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                border: Border.all(
                                                    color: Colors.white),
                                                color: Colors.transparent,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Closed',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(color: Color(0xff876DFF))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.orange.shade800,
                            size: 30,
                          ),
                          GradientText('Expand Your Knowledge',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                              colors: [Color(0xff876DFF), Color(0xffFB692A)]),
                        ],
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WrongAnswerScreen(),
                        ));
                  },
                  child: Container(
                      height: 55,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(color: Color(0xff876DFF))),
                      child: Center(
                        child: GradientText('Check Wrong Answers',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                            colors: [Color(0xff876DFF), Color(0xffFB692A)]),
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
