import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:quizzin_app/modules/authentication_screen_module/screens/signup_screen.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  bool _isVisible = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  // final _auth = FirebaseAuth.instance;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginApi() async {
    setState(() {
      loading = true;
    });
    final response = await DioClientServices.instance.dioPostCall(context,
        url: login,
        isLoading: true,
        headerData: false,
        bodyTag: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim()
        });
    if (response != null && response['status'] == 1) {
      log('my response is ${response}');
      setState(() {
        loading = false;
      });
      token = response['result']['token'].toString();
      await SharedPreference.setStringData(
          key: 'token', value: response['result']['token'].toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationModule(),
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      print('my response is ${response}');
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
                'Login',
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
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp_Screen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'Signup',
                      style: TextStyle(color: Color(0xff876DFF), fontSize: 18),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Email Address',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                  key: _formkey,
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
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      TextFormField(
                        obscureText: _isVisible,
                        controller: passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Enter Password',
                            suffixIcon: GestureDetector(
                                onTap: _toggleVisibility,
                                child: _isVisible
                                    ? Icon(
                                        Icons.visibility_off,
                                        size: 30,
                                        color: Color(0xff876DFF),
                                      )
                                    : Icon(
                                        Icons.visibility,
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
                            return 'Enter Your Password';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 35,
              ),
              const Center(
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Color(0xff876DFF),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              RoundButton(
                loading: loading,
                title: 'Login',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    loginApi();
                  }
                },
              ),

              // GestureDetector(
              //   onTap: () {
              //     if (_formkey.currentState!.validate()) {
              //       login();
              //     }
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //       builder: (context) => const ProfileSetupScreen(),
              //     //     ));
              //   },
              //   child: Container(
              //     height: 60,
              //     width: 500,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(35),
              //         gradient: const LinearGradient(
              //             colors: [Color(0xff876DFF), Color(0xffFB692A)])),
              //     child: const Center(
              //       child: Text(
              //         'Login',
              //         style: TextStyle(color: Colors.white, fontSize: 20),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 60,
              ),
              const Row(
                children: [
                  Expanded(
                    child: Divider(
                      endIndent: 8,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'Or login using',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    indent: 8,
                    color: Colors.white,
                  )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  height: 65,
                  width: 65,
                  child: Image.asset(
                      fit: BoxFit.cover, 'assets/images/Group 241.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Version: 1.0.2',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



 // _auth
      //     .signInWithEmailAndPassword(
      //         email: emailController.text.toString(),
      //         password: passwordController.text.toString())
      //     .then((value) {
      //   Utils().toastMessage(value.user!.email.toString());

      //
      //   setState(() {
      //     loading = false;
      //   });
      // }).onError((error, stackTrace) {
      //   Utils().toastMessage('User not found. Please check your email address');
      //   setState(() {
      //     loading = false;
      //   });
      // });