import 'opcao.m.dart';
import 'questionario.m.dart';

class PerguntaModel {
  int id;
  String pergunta;
  String tipo;
  List<OpcaoModel> opcoes;
  QuestionarioModel questionario;

  PerguntaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pergunta = json['pergunta'];
    tipo = json['tipo'];
    questionario = json['questionario'] != null ? QuestionarioModel.fromJson(json['questionario']) : null;

    if (json['opcoes'] != null) {
      List<OpcaoModel> opcoes = [];
      for (var o in json['opcoes']) opcoes.add(new OpcaoModel.fromJson(o));
      this.opcoes = opcoes;
    }
  }
}
