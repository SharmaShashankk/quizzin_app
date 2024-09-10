import 'package:flutter/material.dart';

Widget resultCard(
    BuildContext context, int score, int totalScore) {
  return Material(
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/CARD-2.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
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
                      border: Border.all(color: const Color(0xff876DFF)),
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/Group 318.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  const Image(
                    image: AssetImage('assets/images/#manukahat.png'),
                    width: 60,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff876DFF)),
                    ),
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/coin 1.png',
                          height: 22,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          totalScore.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
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
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/Great.png',
            height: 50,
            width: 150,
            fit: BoxFit.contain,
          ),
          const Text(
            'Shashank',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          const Text(
            'You earned points',
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            // height: 85,
            // width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.shade900,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: AssetImage('assets/images/coin 1.png'),
                  height: 40,
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  score.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          const Text(
            'for playing quiz of',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xff232149)),
            padding: EdgeInsets.all(5),
            child: Row(
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                Image(
                  image: AssetImage('assets/images/Ram.png'),
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
