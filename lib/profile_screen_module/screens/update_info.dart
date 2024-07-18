import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizzin_app/authentication_screen_module/widgets/button.dart';
// import 'package:quizzin_app/profile_screen_module/screens/my_profile.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  List gender = ['male', 'female', 'other'];
  String? selectedValue = "";

  @override
  void initState() {
    selectedValue = gender[0];

    super.initState();
  }

  final mobileUpdateController = TextEditingController();
  final emailController = TextEditingController();
  final ageUpdateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15, top: 50, right: 15, bottom: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                    width: 15,
                  ),
                  const Text(
                    'Basic Information',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Name *',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    fillColor: const Color(0xff232149),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Gender',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff232149),
                    borderRadius: BorderRadius.circular(25)),
                child: DropdownButtonFormField(
                  dropdownColor: Color(0xff232149),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 30,
                    color: Color(0xff876DFF),
                  ),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.only(left: 20, top: 10, right: 20)),
                  value: selectedValue,
                  items: gender
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: TextStyle(color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Age',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: ageUpdateController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffix: const Text(
                      'Years',
                      style: TextStyle(color: Color(0xff876DFF), fontSize: 17),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    fillColor: const Color(0xff232149),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Email Address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: 'Enter Email Address',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 17),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 13),
                    fillColor: const Color(0xff232149),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Mobile Number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              IntlPhoneField(
                cursorColor: Colors.white,
                disableLengthCheck: true,
                dropdownTextStyle: TextStyle(color: Colors.white),
                style: TextStyle(color: Colors.white),
                controller: mobileUpdateController,
                decoration: InputDecoration(
                    fillColor: Color(0xff232149),
                    filled: true,
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25))),
              ),
              const SizedBox(
                height: 95,
              ),
              RoundButton(
                title: 'Update',
                onTap: () {},
              )
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => const MyProfileScreen(),
              //         ));
              //   },
              //   child: Container(
              //     height: 60,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(35),
              //         gradient: const LinearGradient(
              //             colors: [Color(0xff876DFF), Color(0xffFB692A)])),
              //     child: const Center(
              //       child: Text(
              //         'Update',
              //         style: TextStyle(fontSize: 20, color: Colors.white),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
