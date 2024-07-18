import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  changePassword() async {
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: passwordUpdate,
      isLoading: true,
      bodyTag: {
        'current_password': currentPassController.text,
        'new_password': newPassController.text,
        'confirm_password': confirmPassController.text,
      },
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());
      Navigator.pop(context);
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 50),
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
                  'Update Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: currentPassController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        color: Color(0xff876DFF),
                      ),
                      hintText: 'Enter Current Password',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 17),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 16),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current password';
                    }
                    if (currentPassController.text.trim().length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'New Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: newPassController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        color: Color(0xff876DFF),
                      ),
                      hintText: 'Enter New Password',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 17),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 16),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    if (currentPassController.text.trim().length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  ' Confirm New Password',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: confirmPassController,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.visibility_off,
                        color: Color(0xff876DFF),
                      ),
                      hintText: 'Enter New Password Again',
                      hintStyle:
                          const TextStyle(color: Colors.grey, fontSize: 17),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 16),
                      fillColor: const Color(0xff232149),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your confirm password';
                    }
                    if (currentPassController.text.trim().length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ],
            )),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Color(0xff876DFF), fontSize: 20),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                formKey.currentState?.validate();
                changePassword();
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    gradient: const LinearGradient(
                        colors: [Color(0xff876DFF), Color(0xffFB692A)])),
                child: const Center(
                  child: Text(
                    'Update',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
