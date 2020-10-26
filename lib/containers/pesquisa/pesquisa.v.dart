import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../questionario/models/questionario.m.dart';
import '../questionario/widgets/questionario_card.dart';
import 'controllers/pesquisa.c.dart';

class PesquisaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PesquisaController>(
      init: Get.put(PesquisaController()),
      builder: (ctr) => Scaffold(
        body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
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
                        child: TextFormField(
                            controller: ctr.termo,
                            onFieldSubmitted: (String value) => ctr.getQuestionarios(),
                            decoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10))),
                      ),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: ctr.getQuestionarios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                if (!ctr.questionarios.value.isNullOrBlank)
                  Expanded(
                    child: ListView.builder(
                        itemCount: ctr.questionarios.value.length,
                        itemBuilder: (_, index) {
                          QuestionarioModel questionario = ctr.questionarios.value[index];
                          return QuestionarioCard(questionario: questionario);
                        }),
                  )
              ],
            )),
      ),
    );
  }
}
