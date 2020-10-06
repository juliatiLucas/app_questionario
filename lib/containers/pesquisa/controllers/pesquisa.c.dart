import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api.dart';
import '../../../utils/session.dart';
import '../../questionario/models/questionario.m.dart';
import '../../questionario/models/resposta.m.dart';

class PesquisaController extends GetxController {
  TextEditingController termo = TextEditingController();
  Rx<List<QuestionarioModel>> questionarios = Rx<List<QuestionarioModel>>();
  Rx<List<RespostaModel>> respostas = Rx<List<RespostaModel>>();

  void getRespostas() {}

  void getQuestionarios() async {
    if (this.termo.text.isEmpty) return;

    List<QuestionarioModel> questionarios = [];
    Map<String, dynamic> data = {"questionario": this.termo.text};
    var token = await Session.getToken();
    http
        .post(
      "${Api.address}/questionarios/filtrar",
      body: data,
      headers: token,
    )
        .then((res) {
      if (res.statusCode == 200) {
        for (var q in json.decode(res.body)) questionarios.add(new QuestionarioModel.fromJson(q));
        this.questionarios.value = questionarios;
        update();
      }
    });
  }
}
