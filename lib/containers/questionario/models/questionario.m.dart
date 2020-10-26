import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import '../../empresa/models/empresa.m.dart';
import 'pergunta.m.dart';

class QuestionarioModel {
  int id;
  String titulo;
  EmpresaModel empresa;
  Color cor;
  List<PerguntaModel> perguntas;
  bool respondido;

  QuestionarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    empresa = json['empresa'] != null ? EmpresaModel.fromJson(json['empresa']) : null;
    cor = Color(int.parse(json['cor'].toString().replaceFirst('#', '0xff')));
    respondido = json['respondido'] ?? false;
    List<dynamic> posicao = convert.json.decode(json['posicao']);

    if (json['perguntas'] != null) {
      List<PerguntaModel> perguntas = [];
      List<PerguntaModel> ordenadas = [];
      for (var p in json['perguntas']) perguntas.add(new PerguntaModel.fromJson(p));
      for (int i = 0; i < posicao.length; i++)
        ordenadas.add(perguntas.firstWhere((pergunta) => pergunta.id == posicao[i]));

      this.perguntas = ordenadas;
    }
  }
}
