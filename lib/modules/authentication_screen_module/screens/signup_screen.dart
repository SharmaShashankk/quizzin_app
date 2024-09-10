import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzin_app/models/provider.dart/signup_provider.dart';
import 'package:quizzin_app/modules/authentication_screen_module/screens/login_screen.dart';
import 'package:quizzin_app/modules/authentication_screen_module/widgets/button.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);
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
                  key:signupProvider.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: signupProvider.emailController,
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
                        obscureText: signupProvider.isField1Visible,
                        controller:signupProvider.passwordController,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 13),
                          hintText: 'Enter Password',
                          suffixIcon: GestureDetector(
                              onTap: () {
                              signupProvider.toggleVisibility(1);
                              },
                              child: signupProvider.isField1Visible
                                  ? const Icon(
                                      Icons.visibility,
                                      size: 30,
                                      color: Color(0xff876DFF),
                                    )
                                  : const Icon(
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
                        controller:signupProvider.cnfPasswordController,
                        obscureText: signupProvider.isField2Visible,
                        cursorColor: Colors.white,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 13),
                            hintText: 'Re-Enter Password',
                            suffixIcon: GestureDetector(
                                onTap: () {
                                signupProvider.toggleVisibility(2);
                                },
                                child: signupProvider.isField2Visible
                                    ? const Icon(
                                        Icons.visibility,
                                        size: 30,
                                        color: Color(0xff876DFF),
                                      )
                                    : const Icon(
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
                loading:signupProvider.loading,
                onTap: () {
                  if (signupProvider.formKey.currentState!.validate()) {
                  signupProvider.signUpApi(context);
                   
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
                child: SizedBox(
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
