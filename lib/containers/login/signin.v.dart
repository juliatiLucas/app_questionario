import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/components/rec_input.dart';
import 'controllers/signin.c.dart';
import 'signup.v.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInController>(
        init: Get.put(SignInController()),
        builder: (ctr) => Container(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
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
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Acessar',
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
