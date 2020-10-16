import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/components/snack.dart';
import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';
import '../../home/controllers/home.c.dart';
import '../models/opcao.m.dart';
import '../models/questionario.m.dart';
import '../models/resposta_usuario.dart';

class QuestionarioController extends GetxController {
  static QuestionarioController get to => Get.find();
  HomeController _homeController = Get.put(HomeController());
  Rx<QuestionarioModel> questionario = Rx<QuestionarioModel>();
  Rx<List<RespostaUsuario>> respostas = Rx<List<RespostaUsuario>>();
  Rx<bool> respondido = Rx<bool>(false);

  void addOpcaoResposta(OpcaoModel opcao, int index) {
    this.respostas.value[index].opcao = opcao;
    update();
  }

  void addTextoResposta(String resposta, int index) {
    this.respostas.value[index].resposta = resposta;
    update();
  }

  void setRespondido(bool value) {
    this.respondido.value = value;
    update();
  }

  void clearQuestionario() {
    this.questionario.value = null;
    this.respondido.value = false;
    update();
  }

  void getQuestionario(int questionarioId) async {
    this.clearQuestionario();
    var token = await Session.getToken();
    var userInfo = await Session.getUserInfo();
    QuestionarioModel questionario;
    List<RespostaUsuario> respostas = [];
    http.get("${Api.address}/questionarios/$questionarioId", headers: token).then((res) {
      if (res.statusCode == 200) {
        questionario = new QuestionarioModel.fromJson(json.decode(res.body));

        for (var pergunta in questionario.perguntas) {
          respostas.add(new RespostaUsuario(
            pergunta: pergunta.id,
            usuario: userInfo['id'],
            opcao: null,
          ));
        }

        this.respostas.value = respostas;
        this.questionario.value = questionario;

        update();
      } else if (res.statusCode == 400) {
        setRespondido(true);
      }
    });
  }

  void enviarResposta(BuildContext context) async {
    var token = await Session.getToken();
    List<Map<String, String>> data = [];

    for (var resposta in this.respostas.value) {
      if (resposta.opcao == null && resposta.resposta.isEmpty) {
        Snack.showSnack(title: "Erro", message: "Responda todas as perguntas!");
        return;
      } else {
        data.add({
          "resposta": resposta.resposta,
          "usuario": resposta.usuario.toString(),
          "opcao": resposta?.opcao?.id.toString(),
          "pergunta": resposta.pergunta.toString(),
        });

      }
    }

    http.post(
      "${Api.address}/respostas/",
      body: json.encode(data),
      headers: {'Content-Type': 'application/json', ...token},
    ).then((res) {
      if (res.statusCode == 201) {
        Snack.showSnack(title: "Sucesso", message: "Resposta enviada!");
        List<RespostaUsuario> respostas = this.respostas.value;
        respostas.map((r) => r.opcao = null);
        this.respostas.value = respostas;
        update();
        _homeController.getQuestionarios(context);
        _homeController.getRespostas();
        Future.delayed(Duration(milliseconds: 2000), () {
          Get.close(2);
        });
      }
    });
  }
}
