import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/questionario.m.dart';
import '../questionario.v.dart';

class QuestionarioCard extends StatelessWidget {
  final QuestionarioModel questionario;
  final bool expanded;
  QuestionarioCard({this.questionario, this.expanded = false});

  void abrirQuestionario(BuildContext context) => showDialog(
        context: context,
        builder: (_) => QuestionarioView(questionario: questionario),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(color: questionario.cor, borderRadius: BorderRadius.all(Radius.circular(2))),
        width: expanded ? MediaQuery.of(context).size.width : 200,
        child: Material(
          color: !questionario.respondido ? Colors.transparent : Colors.black.withOpacity(0.22),
          child: InkWell(
            splashColor: Colors.black.withOpacity(0.18),
            highlightColor: Colors.white.withOpacity(0.12),
            onTap: () => !questionario.respondido ? this.abrirQuestionario(context) : null,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  questionario.titulo,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                !questionario.empresa.isNullOrBlank
                    ? Opacity(
                        opacity: 0.8,
                        child: Text(
                          "Empresa: ${questionario.empresa.nome}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : Container(),
                !questionario.empresa.isNullOrBlank
                    ? Opacity(
                        opacity: 0.8,
                        child: Text(
                          "Perguntas: ${questionario.perguntas.length}",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : Container(),
              ]),
            ),
          ),
        ));
  }
}
