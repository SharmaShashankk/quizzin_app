import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quizzin_app/models/provider.dart/login_provider.dart';
import 'package:quizzin_app/modules/authentication_screen_module/screens/signup_screen.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

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
                          builder: (context) => const SignUpScreen(),
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
                  key: loginProvider.formKey,
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
                        controller: loginProvider.emailController,
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
                        obscureText: loginProvider.isVisible,
                        controller: loginProvider.passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Enter Password',
                            suffixIcon: GestureDetector(
                                onTap: loginProvider.toggleVisibility,
                                child: loginProvider.isVisible
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
                    loginProvider.forgotPassword(context);
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
                loading: loginProvider.loading,
                title: 'Login',
                onTap: () {
                  if (loginProvider.formKey.currentState!.validate()) {
                    loginProvider.loginApi(context);
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
                    loginProvider.signInWithGoogle(context);
                  },
                  child: SizedBox(
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
