import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/questionario.m.dart';
import '../controllers/questionario.c.dart';
import '../components/pergunta_card.dart';
import '../models/pergunta.m.dart';

class QuestionarioView extends StatefulWidget {
  final QuestionarioModel questionario;
  QuestionarioView({this.questionario});

  @override
  _QuestionarioViewState createState() => _QuestionarioViewState();
}

class _QuestionarioViewState extends State<QuestionarioView> {
  int getIndex(List<PerguntaModel> perguntas, PerguntaModel pergunta) {
    int index = perguntas.indexOf(pergunta);
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetBuilder(
        init: Get.put(QuestionarioController()),
        initState: (_) {
          QuestionarioController.to.getQuestionario(widget.questionario.id);
        },
        builder: (ctr) => ctr.questionario.value != null
            ? Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: ctr.questionario.value.cor,
                body: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          SafeArea(
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Row(children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: Navigator.of(context).pop,
                                  color: Colors.white,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ctr.questionario.value.titulo.length > 22
                                          ? ctr.questionario.value.titulo.toString().substring(0, 21) + '...'
                                          : ctr.questionario.value.titulo,
                                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Opacity(
                                        opacity: 0.8,
                                        child: Text(
                                          ctr.questionario.value.empresa.nome,
                                          style: TextStyle(color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                              ctr.respostas.value.length > 0
                                  ? Row(children: [
                                      IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.check),
                                        onPressed: ctr.enviarResposta,
                                      )
                                    ])
                                  : SizedBox()
                            ]),
                          ),
                          SizedBox(height: 20),
                          ...ctr.questionario.value.perguntas.length > 0
                              ? ctr.questionario.value.perguntas.map(
                                  (PerguntaModel pergunta) => PerguntaCard(
                                      pergunta: pergunta,
                                      controller: ctr,
                                      index: this.getIndex(ctr.questionario.value.perguntas, pergunta)),
                                )
                              : [
                                  SizedBox(
                                      child: Text(
                                    'Esse questionário não tem perguntas ainda.',
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ))
                                ],
                        ],
                      ),
                    )))
            : ctr.respondido.value
                ? Container(
                    child: Center(
                      child: Text(
                        'Voce ja respondeu a este questionário.',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                : Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
