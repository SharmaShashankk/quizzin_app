import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
// import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class ProfileSetupScreen extends StatefulWidget {
  ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  bool isChecked = false;

  List gender = ['male', 'female', 'other'];
  String? selectedValue = "";

  @override
  void initState() {
    selectedValue = gender[0];

    super.initState();
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  // final genderController = TextEditingController();
  final ageController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();

  setUserDetails() async {
    final response = await DioClientServices.instance
        .dioPostCall(context, url: setUser, isLoading: true, bodyTag: {
      'first_name': firstNameController.text.trim(),
      'last_name': lastNameController.text.trim(),
      'country_code': '+91',
      'contact_number': mobileController.text.trim(),
      'gender': 'male',
      'age': ageController.text.trim(),
      'language_code': 'en',
      'email': emailController.text.trim(),
    });
    if (response != null && response['status'] == 1) {
      log('my response is ${response}');

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigationModule(),
          ));
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: SingleChildScrollView(
            padding: const EdgeInsets.only(top: 70, left: 25, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Setup Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Tell us something about yourself',
                  style: TextStyle(color: Colors.grey, fontSize: 21),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'First Name *',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: firstNameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      hintText: 'Enter your first name',
                      hintStyle: const TextStyle(
                        color: Color(0xff807DAB),
                        fontSize: 20,
                      ),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25))),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Last Name *',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: lastNameController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      hintText: 'Enter your last name',
                      hintStyle: const TextStyle(
                        color: Color(0xff807DAB),
                        fontSize: 20,
                      ),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25))),
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
                  height: 15,
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
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
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
                  height: 15,
                ),
                TextFormField(
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      suffix: const Text(
                        'Years',
                        style: TextStyle(color: Color(0xff876DFF)),
                      ),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25))),
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
                  height: 15,
                ),
                TextFormField(
                  controller: emailController,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 13),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25))),
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
                  height: 15,
                ),
                IntlPhoneField(
                  cursorColor: Colors.white,
                  disableLengthCheck: true,
                  dropdownTextStyle: TextStyle(color: Colors.white),
                  style: TextStyle(color: Colors.white),
                  controller: mobileController,
                  decoration: InputDecoration(
                      fillColor: Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(25))),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChecked = isChecked;
                        });
                      },
                      child: Checkbox(
                        shape: BeveledRectangleBorder(
                            side: const BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(0)),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: 'By continuing, you agree to our\n',
                          style: TextStyle(fontSize: 21)),
                      TextSpan(
                          text: 'Terms of Service ',
                          style: TextStyle(
                              fontSize: 21, color: Color(0xff876DFF))),
                      TextSpan(text: 'and ', style: TextStyle(fontSize: 21)),
                      TextSpan(
                          text: 'Privacy Policy',
                          style:
                              TextStyle(fontSize: 21, color: Color(0xff876DFF)))
                    ]))
                  ],
                ),
              ],
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 15),
            child: GestureDetector(
              onTap: () {
                setUserDetails();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigationModule(),
                    ));
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                        colors: [Color(0xff876DFF), Color(0xffFB692A)])),
                child: const Center(
                  child: Text(
                    'Complete',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
