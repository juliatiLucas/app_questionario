import 'package:flutter/material.dart';
import '../models/questionario.m.dart';

class QuestionarioView extends StatelessWidget {
  final QuestionarioModel questionario;
  QuestionarioView({this.questionario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(questionario.titulo),
      ),
      body: Container(
          child: Column(
        children: [],
      )),
    );
  }
}
