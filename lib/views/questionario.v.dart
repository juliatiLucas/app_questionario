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
  final QuestionarioController _questionarioController = Get.put(QuestionarioController());

  void menu() async {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              height: 280,
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                  "Menu",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: Theme.of(context).primaryColor,
                  child: Text("ENVIAR", style: TextStyle(color: Colors.white)),
                  onPressed: _questionarioController.enviarResposta,
                ),
                SizedBox(height: 10),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.grey[200],
                  child: Text("SAIR"),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Get.back();
                  },
                ),
              ]),
            ));
  }

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
                              Text(
                                ctr.questionario.value.titulo,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.menu),
                                onPressed: this.menu,
                              )
                            ]),
                          ),
                          ...ctr.questionario.value.perguntas.map(
                            (PerguntaModel pergunta) => PerguntaCard(
                                pergunta: pergunta,
                                controller: ctr,
                                index: this.getIndex(ctr.questionario.value.perguntas, pergunta)),
                          )
                        ],
                      ),
                    )),
              )
            : Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
