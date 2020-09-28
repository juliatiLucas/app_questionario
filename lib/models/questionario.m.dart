import 'package:flutter/material.dart';
import './empresa.m.dart';
import './pergunta.m.dart';
import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class QuestionarioModel {
  int id;
  String titulo;
  EmpresaModel empresa;
  Color cor;
  List<PerguntaModel> perguntas;

  QuestionarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    empresa = json['empresa'] != null ? EmpresaModel.fromJson(json['empresa']) : null;
    cor = Color(int.parse(json['cor'].toString().replaceFirst('#', '0xff')));

    if (json['perguntas'] != null) {
      List<PerguntaModel> perguntas = [];
      for (var p in json['perguntas']) perguntas.add(new PerguntaModel.fromJson(p));

      this.perguntas = perguntas;
    }
  }
}
