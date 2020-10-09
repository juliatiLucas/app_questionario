import 'package:flutter/material.dart';

import '../../questionario/models/questionario.m.dart';
import '../../questionario/widgets/questionario_card.dart';
import '../models/empresa.m.dart';

class EmpresaCard extends StatelessWidget {
  final EmpresaModel empresa;
  EmpresaCard({this.empresa});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 8),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Opacity(
          opacity: 0.83,
          child: Text(empresa.nome, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        if (empresa.categoria != null)
          Opacity(
            opacity: 0.8,
            child: Text("Categoria: ${empresa.categoria.nome}"),
          ),
        SizedBox(height: 5),
        if (empresa.questionarios.length <= 4)
          ...empresa.questionarios
              .map((questionario) => Container(
                    decoration: BoxDecoration(color: questionario.cor),
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  ))
              .toList()
        else
          ...empresa.questionarios
              .map((questionario) => Container(
                    decoration: BoxDecoration(color: questionario.cor),
                    height: 25,
                    width: 25,
                    margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                  ))
              .toList(),
      ]),
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        SizedBox(height: 10),
        Opacity(
          opacity: 0.85,
          child: Text(
            "Questionários",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          height: 250,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: empresa.questionarios.length,
                itemBuilder: (_, index) {
                  QuestionarioModel questionario = empresa.questionarios[index];
                  return QuestionarioCard(questionario: questionario, expanded: true);
                }),
          ),
        ),
      ],
    );
  }
}
