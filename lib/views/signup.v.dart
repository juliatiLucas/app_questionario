import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup.c.dart';
import '../components/rec_input.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<SignUpController>(
        init: Get.put(SignUpController()),
        builder: (ctr) => Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.18),
            Padding(
              padding: EdgeInsets.only(left: 16, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(opacity: 0.8, child: Text('Crie sua conta', style: TextStyle(color: Colors.white, fontSize: 16))),
                  Text(
                    'Cadastro',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text('Nome'),
                    RecInput(controller: ctr.name),
                    Text('E-mail'),
                    RecInput(controller: ctr.email),
                    Text('Senha'),
                    RecInput(controller: ctr.password, obscureText: true),
                    SizedBox(height: 25),
                    OutlineButton(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                      highlightColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      splashColor: Theme.of(context).primaryColor.withOpacity(0.2),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                      ),
                      onPressed: () => ctr.signUp(context),
                    ),
                    SizedBox(height: 15),
                  ])),
            ),
          ],
        )),
      ),
    );
  }
}
