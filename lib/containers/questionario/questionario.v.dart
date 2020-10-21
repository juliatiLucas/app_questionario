import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/questionario.c.dart';
import 'models/pergunta.m.dart';
import 'models/questionario.m.dart';
import 'widgets/pergunta_card.dart';

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

  void confirmarSaida(QuestionarioController ctr) {
    if (ctr.questionario.value.perguntas.length > 0) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text("Aviso"),
                content: Container(
                  child: Text('Você tem certeza? Suas respostas não serão salvas.'),
                ),
                actions: [
                  FlatButton(
                    child: Text('CANCELAR'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text('SAIR'),
                      onPressed: () {
                        ctr.clearQuestionario();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }),
                ],
              ));
    } else {
      ctr.clearQuestionario();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.put(QuestionarioController()),
      initState: (_) {
        QuestionarioController.to.getQuestionario(widget.questionario.id);
      },
      builder: (ctr) => ctr.questionario.value != null
          ? Padding(
              padding: EdgeInsets.only(top: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  child: Scaffold(
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
                                        onPressed: () => this.confirmarSaida(ctr),
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
                                    if (ctr.respostas.value.length > 0)
                                      Row(children: [
                                        IconButton(
                                          color: Colors.white,
                                          icon: Icon(Icons.check),
                                          onPressed: () => ctr.enviarResposta(context),
                                        )
                                      ])
                                    else
                                      SizedBox()
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
                                        SizedBox(height: 20),
                                        Container(
                                            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                                            decoration: BoxDecoration(
                                                color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4))),
                                            child: Text(
                                              'Esse questionário não tem perguntas ainda.',
                                              style: TextStyle(fontSize: 16),
                                            ))
                                      ],
                              ],
                            ),
                          )))),
            )
          : ctr.respondido.value
              ? AlertDialog(
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  content: Container(
                    height: 275,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Image.asset('assets/respondido.png', width: 210),
                        Text(
                          'Você já respondeu esse questionário.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18),
                        ),
                        FlatButton(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
                            onPressed: Navigator.of(context).pop,
                            child: Text('FECHAR'))
                      ]),
                    ),
                  ),
                )
              : Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
    );
  }
}
