import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';
import '../../empresa/models/empresa.m.dart';
import '../../login/signin.v.dart';
import '../../questionario/models/questionario.m.dart';
import '../../questionario/models/resposta.m.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  Rx<List<QuestionarioModel>> questionarios = Rx<List<QuestionarioModel>>();
  Rx<List<RespostaModel>> respostas = Rx<List<RespostaModel>>();
  Rx<List<EmpresaModel>> empresas = Rx<List<EmpresaModel>>();

  Future<void> getQuestionarios(BuildContext context) async {
    List<QuestionarioModel> questionarios = [];
    var token = await Session.getToken();
    http.get("${Api.address}/questionarios", headers: token).then((res) {
      Session.checkStatus(context, res.statusCode);

      if (res.statusCode == 200) {
        for (var q in json.decode(res.body)) questionarios.add(new QuestionarioModel.fromJson(q));

        this.questionarios.value = questionarios;

        update();
      }
    });
  }

  Future<void> getRespostas() async {
    List<RespostaModel> respostas = [];
    var token = await Session.getToken();
    var userInfo = await Session.getUserInfo();

    http
        .get(
      "${Api.address}/respostas/usuarios/${userInfo['id']}",
      headers: token,
    )
        .then((res) {
      if (res.statusCode == 200) {
        for (var r in json.decode(res.body)) respostas.add(new RespostaModel.fromJson(r));
        this.respostas.value = respostas;

        update();
      }
    });
  }

  Future<void> getEmpresas() async {
    List<EmpresaModel> empresas = [];
    var token = await Session.getToken();
    http.get("${Api.address}/empresas", headers: token).then((res) {
      if (res.statusCode == 200) {
        for (var e in json.decode(res.body)) empresas.add(new EmpresaModel.fromJson(e));
        this.empresas.value = empresas;
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
