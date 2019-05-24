import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uitest/config/constants.dart';
import 'package:uitest/model/userInfo.dart';

/// auth:wyj
/// desc:本地存储
/// date:20190520

class LocalStorage {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String _userTokenKey = "${Constants.APP_PACKAGE_NAME}_USER_TOKEN";

  ///获取
  static Future<String> getString(String key) async {
    return _prefs.then((_p) {
      return _p.getString(key);
    });
  }

  ///设置
  static Future<bool> setString(String key, String value) async {
    return _prefs.then((_p) {
      return _p.setString(key, value);
    });
  }

  ///删除
  static Future<bool> remove(String key) async {
    return _prefs.then((_p) {
      return _p.remove(key);
    });
  }

  ///获取用户登录TOKEN
  static Future<String> getUserToken() async {
    return getString(_userTokenKey);
  }

  ///设置用户登录TOKEN
  static Future<bool> setUserToken(String token) async {
    if (token == null || token.isEmpty) {
      return remove(_userTokenKey);
    }
    return setString(_userTokenKey, token);
  }

  ///保存用户信息
  static Future<bool> setUserInfo(UserInfo userInfo) async {
    if (userInfo == null) {
      return remove("${Constants.APP_PACKAGE_NAME}_USERINFO");
    }
    var jsonString = json.encode(userInfo.toJson());
    return setString("${Constants.APP_PACKAGE_NAME}_USERINFO", jsonString);
  }

  ///获取存储的用户信息
  static Future<UserInfo> getUserInfo() async {
    var jsonString = await getString("${Constants.APP_PACKAGE_NAME}_USERINFO");
    if (jsonString == null || jsonString == "") {
      return null;
    }
    return UserInfo.fromJson(json.decode(jsonString));
  }
}
