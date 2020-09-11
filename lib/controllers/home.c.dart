import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../utils/session.dart';
import '../views/signin.v.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  void getQuestionarios() {}

  void logout(BuildContext context) async {
    Session.logout().then((res) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => SignInView()), (route) => false);
    });
  }
}
