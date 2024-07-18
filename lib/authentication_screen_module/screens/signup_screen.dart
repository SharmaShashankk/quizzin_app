// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzin_app/authentication_screen_module/screens/login_screen.dart';
import 'package:quizzin_app/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/profile_screen_module/screens/profile_setup.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({super.key});

  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  bool loading = false;
  bool _isField1Visible = true;
  bool _isField2Visible = true;

  void _toggleVisibility(int fieldNumber) {
    setState(() {
      if (fieldNumber == 1) {
        _isField1Visible = !_isField1Visible;
      } else if (fieldNumber == 2) {
        _isField2Visible = !_isField2Visible;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
    super.dispose();
  }

  // FirebaseAuth _auth = FirebaseAuth.instance;

  void signUpApi() async {
    setState(() {
      loading = true;
    });
    final response = await DioClientServices.instance.dioPostCall(context,
        url: signUp,
        isLoading: true,
        headerData: false,
        bodyTag: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'confirm_password': cnfPasswordController.text.trim(),
          'user_type': 'Guest',
        });
    if (response != null && response['status'] == 1) {
      log('my response is ${response}');
      setState(() {
        loading = false;
      });

      await SharedPreference.setStringData(
          key: 'token', value: response['result']['token'].toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSetupScreen(),
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181632),
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 25, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create an account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Color(0xff876DFF), fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              const Text(
                'Email Address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 17,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: emailController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Enter Email Address',
                            hintStyle: const TextStyle(
                              color: Color(0xff807DAB),
                              fontSize: 20,
                            ),
                            fillColor: const Color(0xff232149),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Email Id';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        obscureText: !_isField1Visible,
                        controller: passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          hintText: 'Enter Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                _toggleVisibility(1);
                              },
                              child: _isField1Visible
                                  ? Icon(
                                      Icons.visibility,
                                      size: 30,
                                      color: Color(0xff876DFF),
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      size: 30,
                                      color: Color(0xff876DFF),
                                    )),
                          hintStyle: const TextStyle(
                            color: Color(0xff807DAB),
                            fontSize: 20,
                          ),
                          fillColor: const Color(0xff232149),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Your Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      TextFormField(
                        controller: cnfPasswordController,
                        obscureText: !_isField2Visible,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Re-Enter Password',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  _toggleVisibility(2);
                                },
                                child: _isField2Visible
                                    ? Icon(
                                        Icons.visibility,
                                        size: 30,
                                        color: Color(0xff876DFF),
                                      )
                                    : Icon(
                                        Icons.visibility_off,
                                        size: 30,
                                        color: Color(0xff876DFF),
                                      )),
                            hintStyle: const TextStyle(
                              color: Color(0xff807DAB),
                              fontSize: 20,
                            ),
                            fillColor: const Color(0xff232149),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25))),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Re-Enter your password';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: Text(
                  "Privacy Policy | Terms of Service",
                  style: TextStyle(color: Color(0xff876DFF), fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                title: 'SignUp',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signUpApi();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => ProfileSetupScreen(),
                    //     ));
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 8,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Or signup using',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Expanded(
                      child: Divider(
                    indent: 8,
                    color: Colors.white,
                  ))
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: Container(
                  height: 65,
                  width: 65,
                  child: Image.asset(
                      fit: BoxFit.cover, 'assets/images/Group 241.png'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
