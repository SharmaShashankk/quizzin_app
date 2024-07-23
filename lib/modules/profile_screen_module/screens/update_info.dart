import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';
// import 'package:quizzin_app/profile_screen_module/screens/my_profile.dart';

class UpdateInfoScreen extends StatefulWidget {
  const UpdateInfoScreen({super.key});

  @override
  State<UpdateInfoScreen> createState() => _UpdateInfoScreenState();
}

class _UpdateInfoScreenState extends State<UpdateInfoScreen> {
  List gender = ['male', 'female', 'other'];
  String? selectedValue = "";

  final mobileUpdateController = TextEditingController();
  final emailController = TextEditingController();
  final ageUpdateController = TextEditingController();
  final firstNameController = TextEditingController();

  @override
  void initState() {
    selectedValue = gender[0];
    print('firstName $firstName ');
    mobileUpdateController.text = mobileNumber;
    emailController.text = emailAddress;
    ageUpdateController.text = age;
    firstNameController.text = firstName;
    // selectedValue = genderData;
    super.initState();
  }

  updateInfo() async {
    final response = await DioClientServices.instance
        .dioPostCall(context, url: setUser, isLoading: true, bodyTag: {
      'first_name': firstNameController.text,
      'last_name': 'Sharma',
      'country_code': 91,
      'language_code': 'en',
      'gender': selectedValue,
      'age': int.parse(ageUpdateController.text),
      'email': emailController.text,
      'contact_number': mobileUpdateController.text,
    });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      firstName = response['result']['data']['user']['first_name'];
      gender = response['result']['data']['user']['gender'];
      age = response['result']['data']['user']['age'];
      emailAddress = response['result']['data']['user']['email'];
      mobileNumber = response['result']['data']['user']['mobile_number'];

      Utils().toastMessage(response['result']['message'].toString());
    } else if (response != null && response['status'] == 0) {
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());
    }
  }

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
                controller: firstNameController,
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
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value as String;
                    });
                  },
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
                onTap: () {
                  updateInfo();
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
