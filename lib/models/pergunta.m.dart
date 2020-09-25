import 'dart:convert' show utf8;
import './opcao.m.dart';

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class PerguntaModel {
  int id;
  String pergunta;
  String tipo;
  List<OpcaoModel> opcoes;

  PerguntaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pergunta = utf8convert(json['pergunta']);
    tipo = json['tipo'];

    if (json['opcoes'] != null) {
      List<OpcaoModel> opcoes = [];
      for (var o in json['opcoes']) opcoes.add(new OpcaoModel.fromJson(o));
      this.opcoes = opcoes;
    }
  }
}
