import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../utils/session.dart';
import '../views/signin.v.dart';
import '../models/questionario.m.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  Rx<List<QuestionarioModel>> questionarios = Rx<List<QuestionarioModel>>();

  Future<void> getQuestionarios() async {
    List<QuestionarioModel> questionarios = [];
    var token = await Session.getToken();
    http.get("${Api.address}/questionarios", headers: token).then((res) {
      if (res.statusCode == 200) {
        for (var q in json.decode(res.body)) questionarios.add(new QuestionarioModel.fromJson(q));

        this.questionarios.value = questionarios;
        update();
      }
    });
  }

  void logout(BuildContext context) async {
    Session.logout().then((res) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => SignInView()), (route) => false);
    });
  }
}
