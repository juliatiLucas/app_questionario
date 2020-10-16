import 'package:flutter/material.dart';
import '../models/resposta.m.dart';

class RespostaCard extends StatelessWidget {
  final RespostaModel resposta;
  RespostaCard({this.resposta});

  void showInfo(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        height: 180,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      resposta.pergunta.pergunta,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: resposta.pergunta.questionario.cor,
                          borderRadius: BorderRadius.all(Radius.circular(2.5))),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Opacity(
                    opacity: 0.8,
                    child: Text("R: " + (resposta.resposta.length > 0 ? resposta.resposta : resposta?.opcao?.opcao),
                        style: TextStyle(fontSize: 18))),
                Expanded(child: Container()),
                Align(alignment: Alignment.bottomRight, child: Text(resposta.data)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => showInfo(context),
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
