import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/session.dart';
import '../utils/api.dart';
import '../components/snack.dart';
import '../models/questionario.m.dart';
import '../models/resposta.m.dart';
import '../models/opcao.m.dart';

class QuestionarioController extends GetxController {
  static QuestionarioController get to => Get.find();
  Rx<QuestionarioModel> questionario = Rx<QuestionarioModel>();
  Rx<List<Resposta>> respostas = Rx<List<Resposta>>();

  void addOpcaoResposta(OpcaoModel opcao, int index) {
    this.respostas.value[index].opcao = opcao;
    update();
  }

  void addTextoResposta(String resposta, int index) {
    this.respostas.value[index].resposta = resposta;
    update();
  }

  void getQuestionario(int questionarioId) async {
    var token = await Session.getToken();
    var userInfo = await Session.getUserInfo();
    QuestionarioModel questionario;
    List<Resposta> respostas = [];
    http.get("${Api.address}/questionarios/$questionarioId", headers: token).then((res) {
      if (res.statusCode == 200) {
        questionario = new QuestionarioModel.fromJson(json.decode(res.body));

        for (var pergunta in questionario.perguntas) {
          respostas.add(new Resposta(
            pergunta: pergunta.id,
            usuario: userInfo['id'],
            opcao: null,
          ));
        }

        this.respostas.value = respostas;
        this.questionario.value = questionario;
        update();
      }
    });
  }

  void enviarResposta() async {
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
        List<Resposta> respostas = this.respostas.value;
        respostas.map((r) => r.opcao = null);
        this.respostas.value = respostas;
        update();
      }
    });
  }
}
