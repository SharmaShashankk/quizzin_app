import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizzin_app/modules/base_module/bottom_navigation.dart';
import 'package:quizzin_app/services/dio_client_service.dart';
import 'package:quizzin_app/utils/api_url_string.dart';
import 'package:quizzin_app/utils/utils.dart';

class ProfileSetupProvider extends ChangeNotifier {
  // Controllers for TextFields//
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  bool isChecked = false;
  List<String> genderOptions = ['male', 'female', 'others'];
  String selectedGender = 'male';

  // bool get isChecked => _isChecked;
  // String get selectedGender => _selectedGender;

  void initializeGender() {
    selectedGender = genderOptions[0];
    notifyListeners();
  }

  void setSelectedGender(String gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void toggleCheckbox() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void setCheckboxValue(bool value) {
    isChecked = value;
    notifyListeners();
  }
  // Dispose Controllers when not needed//

  Future<void> setUserDetails(BuildContext context) async {
    final response = await DioClientServices.instance.dioPostCall(context,
        bodyTag: {
          'first_name': firstNameController.text.trim(),
          'last_name': lastNameController.text.trim(),
          'country_code': '+91',
          'contact_number': mobileController.text.trim(),
          'gender': selectedGender,
          'age': ageController.text.trim(),
          'language_code': 'en',
          'email': emailController.text.trim()
        },
        url: setUser,
        isLoading: true);

    if (response != null && response['status'] == 1) {
      log('Response:$response');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationModule(),
          ));
    } else if (response != null && response['status'] == 0) {
      log('Response: $response');
      Utils().toastMessage(response['result']['message'].toString());
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    mobileController.dispose();
    super.dispose();
  }
}
