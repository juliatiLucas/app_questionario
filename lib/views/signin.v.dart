import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signin.c.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<SignInController>(
        init: Get.put(SignInController()),
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
                  Opacity(opacity: 0.8, child: Text('Bem-vindo', style: TextStyle(color: Colors.white, fontSize: 16))),
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    Text('E-mail'),
                    TextField(
                      controller: ctr.email,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10)),
                    ),
                    SizedBox(height: 15),
                    Text('Senha'),
                    TextField(
                      controller: ctr.password,
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10)),
                    ),
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
                      onPressed: () {},
                    )
                  ])),
            ),
          ],
        )),
      ),
    );
  }
}
