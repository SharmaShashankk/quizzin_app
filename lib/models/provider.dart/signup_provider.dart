import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/profile_screen_module/screens/profile_setup.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/services/shared_preference.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class SignupProvider extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  bool _isField1Visible = true;
  bool _isField2Visible = true;

  bool get isField1Visible => _isField1Visible;
  bool get isField2Visible => _isField2Visible;

  void toggleVisibility(int fieldNumber) {
    if (fieldNumber == 1) {
      _isField1Visible = !_isField1Visible;
    } else if (fieldNumber == 2) {
      _isField2Visible = !_isField2Visible;
    }
    notifyListeners();
  }

  Future<void> signUpApi(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    loading = true;
    notifyListeners();

    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
          'confirm_password': cnfPasswordController.text.trim(),
          'user_type': 'Guest'
        },
        url: signUp,
        isLoading: true);

    if (response != null && response['status'] == 1) {
      log('my response is $response');
      loading = false;
      notifyListeners();

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
      log('my response is $response');
      Utils().toastMessage(response['result']['message'].toString());

      loading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cnfPasswordController.dispose();
    super.dispose();
  }
}
