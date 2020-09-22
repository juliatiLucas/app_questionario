import 'package:flutter/material.dart';
import '../models/questionario.m.dart';

class QuestionarioCard extends StatelessWidget {
  final QuestionarioModel questionario;
  QuestionarioCard({this.questionario});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
        decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(4))),
        width: 200,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.black.withOpacity(0.18),
            highlightColor: Colors.white.withOpacity(0.12),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  questionario.titulo,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
        ));
  }
}
