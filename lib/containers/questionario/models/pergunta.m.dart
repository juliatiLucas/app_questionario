import './opcao.m.dart';
import './questionario.m.dart';
import '../../../core/components/utf8_converter.dart' as convert;

class PerguntaModel {
  int id;
  String pergunta;
  String tipo;
  List<OpcaoModel> opcoes;
  QuestionarioModel questionario;

  PerguntaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pergunta = convert.utf8convert(json['pergunta']);
    tipo = json['tipo'];
    questionario = json['questionario'] != null ? QuestionarioModel.fromJson(json['questionario']) : null;

    if (json['opcoes'] != null) {
      List<OpcaoModel> opcoes = [];
      for (var o in json['opcoes']) opcoes.add(new OpcaoModel.fromJson(o));
      this.opcoes = opcoes;
    }
  }
}
