import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static late final SharedPreferences _preference;

  void reloadPreference() async {
    await _preference.reload();
  }

  static Future<void> init() async {
    _preference = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _preference.clear();
  }
}
