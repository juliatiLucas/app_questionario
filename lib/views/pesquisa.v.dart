import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/questionario_card.dart';
import '../models/questionario.m.dart';
import '../components/rec_input.dart';
import '../controllers/pesquisa.c.dart';

class PesquisaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PesquisaController>(
      init: Get.put(PesquisaController()),
      builder: (ctr) => Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Get.back(),
                        color: Colors.black,
                      ),
                      Expanded(
                        child: RecInput(
                            controller: ctr.termo,
                            autoFocus: true,
                            bottomPadding: false,
                            hintText: "Pesquisar questionário"),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: ctr.getQuestionarios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                !ctr.questionarios.value.isNullOrBlank
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: ctr.questionarios.value.length,
                            itemBuilder: (_, index) {
                              QuestionarioModel questionario = ctr.questionarios.value[index];
                              return QuestionarioCard(questionario: questionario);
                            }),
                      )
                    : SizedBox()
              ],
            )),
      ),
    );
  }
}
