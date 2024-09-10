import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/modules/profile_screen_module/screens/profile_setup.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/globals.dart';
import 'package:quizzin_app/utils/utils.dart';

class LoginProvider extends ChangeNotifier {
  bool _loading = false;
  bool _isVisible = true;

  bool get loading => _loading;
  bool get isVisible => _isVisible;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GlobalKey<FormState> get formKey => _formKey;
  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  void clearCredentials() {
    emailController.clear();
    passwordController.clear();
  }

  Future<void> loginApi(BuildContext context) async {
    _setLoading(true);

    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
        url: login,
        isLoading: true);
    if (response != null && response['status'] == 1) {
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
      Utils().toastMessage(response['result']['message'].toString());
    }
    _setLoading(false);
    clearCredentials();
  }

  Future<void> forgotPassword(BuildContext context) async {
    if (emailController.text.isEmpty) {
      Utils().toastMessage('Please Enter Your Email Address');
      return;
    }
    _setLoading(true);
    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {'email': emailController.text.trim()},
        url: resetPassword,
        isLoading: false);

    if (response != null && response['status'] == 1) {
      Utils().toastMessage('Password reset link sent to your email');
    } else {
      Utils().toastMessage(response['result']['message'].toString());
    }
    _setLoading(false);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
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
          await socialMediaLogin(user, context);
        }
      }
    } catch (e) {
      Utils().toastMessage('Google sign-in failed: $e');
    }
  }

  Future<void> socialMediaLogin(User user, BuildContext context) async {
    _setLoading(true);

    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {
          'platform': 'gmail',
          'smToken': user.uid,
          'email': user.email,
        },
        url: socialLogin,
        isLoading: true);

    if (response != null && response['status'] == 1) {
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
    } else if (response! - null && response['status'] == 2) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileSetupScreen(),
        ),
        (route) => false,
      );
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
