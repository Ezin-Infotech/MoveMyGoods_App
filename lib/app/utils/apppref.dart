import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static late final SharedPreferences _preference;
  static const _userToken = "user_token";
  static const _userProfileId = 'userProfileId';

  //User Token
  static String get userToken => _preference.getString(_userToken) ?? "";
  static set userToken(String value) =>
      _preference.setString(_userToken, value);

  //User ProfileId
  static String get userProfileId =>
      _preference.getString(_userProfileId) ?? "";
  static set userProfileId(String value) =>
      _preference.setString(_userProfileId, value);

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
