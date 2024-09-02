import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzin_app/modules/authentication_screen_module/screens/signup_screen.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/modules/profile_screen_module/screens/profile_setup.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();

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

  final FirebaseAuth auth = FirebaseAuth.instance;

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
      log('my response is $response');
      setState(() {
        loading = false;
      });
      token = response['result']['token'].toString();
      await SharedPreference.setStringData(
          key: 'token', value: response['result']['token'].toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationModule(),
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());

      setState(() {
        loading = false;
      });
    }
  }

  void forgotPassword() async {
    if (emailController.text.isEmpty) {
      Utils().toastMessage('Please enter your email address');
      return;
    }
    setState(() {
      loading = false;
    });
    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {'email': emailController.text.trim()},
        url: resetPassword,
        headerData: false,
        isLoading: false);

    if (response != null && response['status'] == 1) {
      Utils().toastMessage('Password reset link sent to your email');
    } else if (response != null) {
      Utils().toastMessage(response['result']['message'].toString());
    } else {
      Utils().toastMessage('Something went wrong. Please try again later.');
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          socialMediaLogin(user);
        }
      }
    } catch (e) {
      Utils().toastMessage('Google sign-in failed: $e');
    }
  }

  void socialMediaLogin(User? user) async {
    setState(() {
      loading = false;
    });
    final response = await DioClientServices.instance.dioPostCall(context,
        url: socialLogin,
        isLoading: true,
        headerData: false,
        bodyTag: {
          'platform': 'gmail',
          'smToken': user?.uid,
          'email': user?.email,
        });
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      setState(() {
        loading = false;
      });
      token = response['result']['token'].toString();
      await SharedPreference.setStringData(
          key: 'token', value: response['result']['token'].toString());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigationModule(),
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      print('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());

      setState(() {
        loading = false;
      });
    } else if (response != null && response['status'] == 2) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSetupScreen(),
        ),
        (route) => false,
      );
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
              Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                    ? const Icon(
                                        Icons.visibility_off,
                                        size: 30,
                                        color: Color(0xff876DFF),
                                      )
                                    : const Icon(
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
              Center(
                child: GestureDetector(
                  onTap: () {
                    forgotPassword();
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                        color: Color(0xff876DFF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
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
                child: GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Container(
                    height: 75,
                    width: 75,
                    child: SvgPicture.asset('assets/images/Group 241.svg'),
                  ),
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
