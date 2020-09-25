import 'package:flutter/material.dart';
import '../models/opcao.m.dart';
import '../models/pergunta.m.dart';
import './rec_input.dart';
import '../controllers/questionario.c.dart';

class PerguntaCard extends StatelessWidget {
  final PerguntaModel pergunta;
  final int index;
  final QuestionarioController controller;
  PerguntaCard({this.pergunta, this.index, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2)), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.34),
          offset: Offset(0, 2.6),
          blurRadius: 2,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Opacity(
            opacity: 0.75,
            child: Text(
              pergunta.pergunta,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          if (pergunta.tipo == "aberta")
            RecInput(onChanged: (String value) => controller.addTextoResposta(value, index))
          else
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(2))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<OpcaoModel>(
                          value: controller.respostas.value[index].opcao,
                          icon: SizedBox(),
                          iconSize: 20,
                          underline: SizedBox(),
                          onChanged: (OpcaoModel value) {
                            controller.addOpcaoResposta(value, index);
                          },
                          items: pergunta.opcoes.map<DropdownMenuItem<OpcaoModel>>((OpcaoModel value) {
                            return DropdownMenuItem<OpcaoModel>(
                              value: value,
                              child: Text(value.opcao),
                            );
                          }).toList(),
                        ),
                      ),
                      Icon(Icons.arrow_drop_down, size: 20)
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
