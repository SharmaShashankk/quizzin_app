import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: 830,
          width: 300,
          decoration: const BoxDecoration(
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
                const Text(
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
                const SizedBox(
                  height: 55,
                ),
                Container(
                  height: 340,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/Group 318.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 310,
                  width: 400,
                  decoration: const BoxDecoration(
                      color: Color(0xff876DFF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(90))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Stack(
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
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _launchURL(
                                    'https://www.youtube.com/@ManuKahat');
                              },
                              child: SvgPicture.asset(
                                'assets/images/Youtube.svg',
                                height: 75,
                                width: 75,
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _launchURL(
                                    'https://www.instagram.com/manukahat/');
                              },
                              child: SvgPicture.asset(
                                'assets/images/instagram 3.svg',
                                height: 75,
                                width: 75,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'More than 500k Subscribers',
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                        const SizedBox(
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
                              borderRadius: BorderRadius.circular(35),
                              border: Border.all(color: Colors.white),
                              color: Colors.transparent,
                            ),
                            child: const Center(
                              child: Text(
                                'Closed',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
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
}

void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
