import './questionario.m.dart';
import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class PerguntaModel {
  int id;
  String pergunta;
  String tipo;
  QuestionarioModel questionario;

  PerguntaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pergunta = utf8convert(json['pergunta']);
    tipo = json['tipo'];
    questionario = QuestionarioModel.fromJson(json['questionario']);
  }
}
