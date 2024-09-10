// import 'dart:developer';
// import 'package:quizzin_app/services/dio_client_service.dart';
// import 'package:quizzin_app/utils/api_url_string.dart';
// import 'package:quizzin_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:quizzin_app/models/provider.dart/profile_setup_provider.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';

class ProfileSetupScreen extends StatefulWidget {
  
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  @override
  void initState() {
    Provider.of<ProfileSetupProvider>(context, listen: false).initializeGender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileSetupProvider = Provider.of<ProfileSetupProvider>(context);
    
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
                  controller: profileSetupProvider.firstNameController,
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
                  controller: profileSetupProvider.lastNameController,
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
                      color: const Color(0xff232149),
                      borderRadius: BorderRadius.circular(25)),
                  child: DropdownButtonFormField(
                    dropdownColor: const Color(0xff232149),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Color(0xff876DFF),
                    ),
                    decoration: const InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        contentPadding:
                            EdgeInsets.only(left: 20, top: 10, right: 20)),
                    value: profileSetupProvider.selectedGender,
                    items: profileSetupProvider.genderOptions
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
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
                  controller: profileSetupProvider.ageController,
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
                  controller: profileSetupProvider.emailController,
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
                  dropdownTextStyle: const TextStyle(color: Colors.white),
                  style: const TextStyle(color: Colors.white),
                  controller: profileSetupProvider.mobileController,
                  decoration: InputDecoration(
                      fillColor: const Color(0xff232149),
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
                    Consumer<ProfileSetupProvider>(
                      builder: (context, profileSetupProvider, child) {
                        return Checkbox(
                          shape: BeveledRectangleBorder(
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(0)),
                          value: profileSetupProvider.isChecked,
                          onChanged: (value) {
                            profileSetupProvider.setCheckboxValue(value!);
                          },
                        );
                      },
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
                profileSetupProvider.setUserDetails(context);
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
