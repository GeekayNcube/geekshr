import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';



class PreferencesManager {
  static final PreferencesManager _preferencesManagerInstance = PreferencesManager._();

  PreferencesManager._();

  static PreferencesManager getInstance() {
    return _preferencesManagerInstance;
  }

  late SharedPreferences _sharedPreferences;

  Future<SharedPreferences> getPreferences() async {
    _sharedPreferences= await SharedPreferences.getInstance();
    log("PreferencesManager: getPreferences");
    return _sharedPreferences;
  }


  void setStringValue(String key, String value) async {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    sharedPreferences.setString(key, value);
  }

  String getStringValue(String key) {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    return sharedPreferences.getString(key)??'';
  }
  void setDoubleValue(String key, double value) async {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    sharedPreferences.setDouble(key, value);
  }

  double getDoubleValue(String key) {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    return sharedPreferences.getDouble(key)??0.0;
  }

  void setIntValue(String key, int value) async {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    sharedPreferences.setInt(key, value);
  }

  int getIntValue(String key) {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    return sharedPreferences.getInt(key) ?? 0;
  }

  void setBoolValue(String key, bool value) async {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    sharedPreferences.setBool(key, value);
  }

  bool getBoolValue(String key) {
    final SharedPreferences sharedPreferences = _sharedPreferences;
    return sharedPreferences.getBool(key) ?? false;
  }

  void removeValue(String key){
    final SharedPreferences sharedPreferences = _sharedPreferences;
    sharedPreferences.remove(key);
  }
}
