import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static Future<bool> setIntData({
    String? key,
    int? value,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.setInt(key!, value!);
  }

  static Future<bool> setBoolData({
    String? key,
    bool? value,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.setBool(key!, value!);
  }

  static Future<bool> setStringData({
    String? key,
    String? value,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.setString(key!, value!);
  }

  static Future<bool> setdoubleData({
    String? key,
    double? value,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.setDouble(key!, value!);
  }

  static Future<int?> getIntData({
    String? key,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.getInt(key!);
  }

  static Future<bool?> getboolData({
    String? key,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.getBool(key!);
  }

  static Future<double?> getdoubleData({
    String? key,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.getDouble(key!);
  }

  static Future<String?> getStringData({
    String? key,
  }) async {
    SharedPreferences sharedPreferenceInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferenceInstance.getString(key!);
  }

  static Future<bool> removeData({String? key}) async {
    SharedPreferences sharedPreferencesInstance =
        await SharedPreferences.getInstance();

    return await sharedPreferencesInstance.remove(key!);
  }

  static Future clearedSharedPreferenceData() async {
    SharedPreferences sharedPreferencesInstance =
        await SharedPreferences.getInstance();

    sharedPreferencesInstance.clear();
  }
}
