import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './signup.v.dart';
import '../../core/rec_input.dart';
import 'controllers/signin.c.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<SignInController>(
        init: Get.put(SignInController()),
        builder: (ctr) => Container(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 240,
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Opacity(
                          opacity: 0.8, child: Text('Bem-vindo', style: TextStyle(color: Colors.white, fontSize: 16))),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                        'Acessar',
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                      ),
                      onPressed: () => ctr.login(context),
                    ),
                    SizedBox(height: 15),
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Cadastre-se',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      onPressed: () => Get.to(SignUpView(), transition: Transition.rightToLeft),
                    )
                  ])),
            ],
          ),
        )),
      ),
    );
  }
}
