import './empresa.m.dart';
import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class QuestionarioModel {
  int id;
  String titulo;
  EmpresaModel empresa;

  QuestionarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    empresa = EmpresaModel.fromJson(json['empresa']);
  }
}
