// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const String KEY_PREFS_USER_ID = "KEY_PREFS_USER_ID";
const String IS_LOCAL_DB_CREATED = "IS_LOCAL_DB_CREATED";
const String IS_REMOTE_TODOS_STORED = "IS_REMOTE_TODOS_STORED";
const String USER_LOGGED_IN = "USER_LOGGED_IN";

class AppPreferences {
  AppPreferences({required this.preferences});
  SharedPreferences preferences;
  Future<void> setLoggedIn(bool value) async {
    await preferences.setBool(USER_LOGGED_IN, value);
  }

  bool isLoggedIn() {
    return preferences.getBool(USER_LOGGED_IN) ?? false;
  }

  Future<void> setLocalDbCreated(bool value) async {
    await preferences.setBool(IS_LOCAL_DB_CREATED, value);
  }

  bool isLocalDbCreated() {
    return preferences.getBool(IS_LOCAL_DB_CREATED) ?? false;
  }

  bool isRemoteTodosStored() {
    return preferences.getBool(IS_REMOTE_TODOS_STORED) ?? false;
  }

  Future<void> setRemoteTodosStored(bool value) async {
    await preferences.setBool(IS_REMOTE_TODOS_STORED, value);
  }

  Future<void> saveUserId(int userId) async {
    await preferences.setInt(KEY_PREFS_USER_ID, userId);
  }

  int getUserId() {
    return preferences.getInt(KEY_PREFS_USER_ID) ?? 0;
  }
}
