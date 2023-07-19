import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setCache({required String key, required String value}) async {
    await sharedPreferences?.setString(key, value);
  }

  static getCache({required String key}) {
    return sharedPreferences?.get(key);
  }
}
