import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/signup.c.dart';
import '../../core/components/rec_input.dart';

class SignUpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignUpController>(
        init: Get.put(SignUpController()),
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
                          opacity: 0.8,
                          child: Text('Crie sua conta', style: TextStyle(color: Colors.white, fontSize: 16))),
                      Text(
                        'Cadastro',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      Text('Nome'),
                      RecInput(controller: ctr.name),
                      Text('E-mail'),
                      RecInput(controller: ctr.email),
                      Text('Telefone'),
                      RecInput(controller: ctr.phone, keyboardType: TextInputType.number),
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
                      FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        onPressed: Navigator.of(context).pop,
                      )
                    ]),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}
