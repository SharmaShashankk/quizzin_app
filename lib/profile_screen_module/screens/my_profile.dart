import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizzin_app/authentication_screen_module/screens/login_screen.dart';
import 'package:quizzin_app/language_screen_module/screens/language_screen.dart';
import 'package:quizzin_app/profile_screen_module/screens/update_info.dart';
import 'package:quizzin_app/profile_screen_module/screens/update_password.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  // final auth = FirebaseAuth.instance;
  XFile? _imageFile;
  getFromGallery(BuildContext context) async {
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _imageFile = pickedFile;
      setProfileImage();
      ();
    } else {
      // showCustomInfoSnack(context, 'no file selected');
      // log("no file selected");
    }
  }

  getFromCamera(BuildContext context) async {
    dynamic pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      _imageFile = pickedFile;
      setProfileImage();

      ();
    } else {
      // showCustomInfoSnack(context, 'no file selected');
      // log("no file selected");
    }
  }

  setProfileImage() async {
    final response = await DioClientServices.instance
        .dioPostCall(context, url: profilePicture, isLoading: true, bodyTag: {
      'profile_image': _imageFile != null
          ? await MultipartFile.fromFile(_imageFile!.path,
              filename: _imageFile!.name)
          : null
    });
    if (response != null && response['status'] == 1) {
      profileImage = response['result']['imagePath'];
      setState(() {});
      log('my response is ${response}');
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  logoutApp() async {
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: logoutApi,
      isLoading: true,
      bodyTag: {'Shashank': 'Sharma'},
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());
      await SharedPreference.clearedSharedPreferenceData();

      clearGlobalData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'][0].toString());
    }
  }

  removeAccount() async {
    final response = await DioClientServices.instance.dioPostCall(
      context,
      url: deleteAccount,
      isLoading: true,
      bodyTag: {'Shashank': 'Sharma'},
    );
    if (response != null && response['status'] == 1) {
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
        (route) => false,
      );
    } else if (response != null && response['status'] == 0) {
      log('my response is ${response}');

      Utils().toastMessage(response['result']['message'][0].toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
          ),
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () async {
                      logoutApp();
                    },
                    icon: Icon(
                      Icons.logout_rounded,
                      size: 40,
                      color: Color(0xff876DFF),
                    )))
          ],
          backgroundColor: const Color(0xff181632),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: const Color(0xff181632),
        body: Padding(
          padding: const EdgeInsets.only(left: 17, right: 17, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'General',
                  style: TextStyle(color: Color(0xff807DAB), fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 130,
                  width: 450,
                  padding: const EdgeInsets.only(left: 10, right: 30, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xff232149)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xff232149),
                                    actions: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 25,
                                          ),
                                          Text(
                                            'Change Picture',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  getFromCamera(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  height: 150,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Color(0xff181632)),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/camera 1.png'),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  getFromGallery(context);
                                                },
                                                child: Container(
                                                  padding:
                                                      EdgeInsets.only(top: 20),
                                                  height: 150,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Color(0xff181632),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/picture (1) 1.png'),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 35,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 17),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                profileImage == ''
                                    ? CircleAvatar(
                                        radius: 30,
                                      )
                                    : CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(profileImage),
                                      ),
                                Positioned(
                                    left: 40,
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                      size: 20,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Shashank Sharma',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UpdateInfoScreen(),
                              ));
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Update Basic Information',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff876DFF),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 30),
                  height: 55,
                  width: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xff232149)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpdatePasswordScreen(),
                          ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Update Password',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xff876DFF),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  'Personalization',
                  style: TextStyle(color: Color(0xff807DAB), fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 30),
                  height: 55,
                  width: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xff232149)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Invite People',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Icon(
                        Icons.ios_share_outlined,
                        color: Color(0xff876DFF),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 12, right: 30),
                  height: 55,
                  width: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xff232149)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageScreen(),
                          ));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Language',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Color(0xff876DFF),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    removeAccount();
                  },
                  child: Container(
                    height: 55,
                    width: 450,
                    padding:
                        const EdgeInsets.only(left: 12, right: 30, top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color(0xff232149)),
                    child: const Text(
                      'Delete Account Permanently',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Contact Us',
                  style: TextStyle(color: Color(0xff807DAB), fontSize: 18),
                ),
                const SizedBox(
                  height: 23,
                ),
                Container(
                  height: 55,
                  width: 450,
                  padding: const EdgeInsets.only(left: 12, right: 30, top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xff232149)),
                  child: const Text(
                    'hello@quizzin.app',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Center(
                  child: Text(
                    'Privacy Policy | Terms of Service',
                    style: TextStyle(color: Color(0xff918EC9), fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    'Version: 1.0.2',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 70,
                  width: 450,
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: const Border(
                        bottom: BorderSide(color: Color(0xff232149)),
                        left: BorderSide(color: Color(0xff232149)),
                        right: BorderSide(color: Color(0xff232149)),
                        top: BorderSide(color: Color(0xff232149)),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border(
                                  bottom: BorderSide(
                                      color: Color(0xff918EC9), width: 1),
                                  left: BorderSide(
                                      color: Color(0xff918EC9), width: 1),
                                  right: BorderSide(
                                      color: Color(0xff918EC9), width: 1),
                                  top: BorderSide(
                                      color: Color(0xff918EC9), width: 1),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  textAlign: TextAlign.center,
                                  'c',
                                  style: TextStyle(color: Color(0xff918EC9)),
                                ),
                              )),
                          const SizedBox(
                            width: 4,
                          ),
                          const Text(
                            'Quizzin : 2024',
                            style: TextStyle(
                                color: Color(0xff918EC9),
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                                text: 'an app by ',
                                style: TextStyle(
                                    color: Color(0xff918EC9), fontSize: 17)),
                            TextSpan(
                                text: '#manukahat',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    'Developed by',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Center(
                    child: Image.asset(
                        height: 50,
                        width: 500,
                        fit: BoxFit.contain,
                        'assets/images/logo color 1.png')),
              ],
            ),
          ),
        ));
  }
}
