import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/rec_input.dart';

class PesquisaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
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
                      bottomPadding: false,
                      hintText: "Pesquisar",
                    )),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {},
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
