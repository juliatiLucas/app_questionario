import 'package:flutter/material.dart';

import '../../questionario/models/questionario.m.dart';
import '../../questionario/widgets/questionario_card.dart';
import '../models/empresa.m.dart';

class EmpresaCard extends StatelessWidget {
  final EmpresaModel empresa;
  EmpresaCard({this.empresa});

  void empresaModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(empresa.nome),
              contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
              titlePadding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: 300,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return null;
                  },
                  child: ListView.builder(
                      itemCount: empresa.questionarios.length,
                      itemBuilder: (_, index) {
                        QuestionarioModel questionario = empresa.questionarios[index];
                        return QuestionarioCard(questionario: questionario, expanded: true);
                      }),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          boxShadow: [BoxShadow(blurRadius: 2.5, offset: Offset(0, 1.8), color: Colors.black.withOpacity(0.26))]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => this.empresaModal(context),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  empresa.nome,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                ...[
                  Text(
                    "Questionarios: ${empresa.questionarios.length}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                  else ...[
                    ...empresa.questionarios
                        .map((questionario) => Container(
                              decoration: BoxDecoration(color: questionario.cor),
                              height: 25,
                              width: 25,
                              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                            ))
                        .toList(),
                    Padding(padding: EdgeInsets.only(left: 5), child: Text('...'))
                  ]
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
