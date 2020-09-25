import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../main.dart';

class Session {
  static Future<Map<String, dynamic>> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userData = await json.decode(prefs.getString('userData'));
    return userData;
  }

  static Future<void> login(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isAuthenticated', true);
    prefs.setString('userData', json.encode(userData));
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', '{}');
    prefs.setBool('isAuthenticated', false);
  }

  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<Map<String, String>> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {"Authorization": "Bearer ${prefs.getString('token')}"};
  }

  static Future<bool> isAuthenticated() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated');
  }

  static checkStatus(BuildContext context, int status) async {
    if (status == 401) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', '{}');
      prefs.setBool('isAuthenticated', false);
      Wrapper.restartApp(context);
    }
  }
}
