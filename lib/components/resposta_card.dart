import 'package:flutter/material.dart';
import '../models/resposta.m.dart';

class RespostaCard extends StatelessWidget {
  final RespostaModel resposta;
  RespostaCard({this.resposta});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: resposta.pergunta.questionario.cor,
                        borderRadius: BorderRadius.all(Radius.circular(2.5))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.9,
                          child: Text(
                            "Questionario: " + resposta?.pergunta?.questionario?.titulo ?? "",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 5),
                        Opacity(opacity: 0.8, child: Text(resposta.pergunta.pergunta, style: TextStyle(fontSize: 16))),
                        Opacity(
                            opacity: 0.8,
                            child: Text(
                                "Resposta: " +
                                    (resposta.resposta.length > 0 ? resposta.resposta : resposta?.opcao?.opcao),
                                style: TextStyle(fontSize: 16))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
