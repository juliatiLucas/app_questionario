import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/api.dart';
import '../utils/session.dart';
import '../components/snack.dart';
import '../views/home.v.dart';

class SignUpController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();

  void signUp(BuildContext context) {
    if (this.name.text.isEmpty || this.email.text.isEmpty || this.password.text.isEmpty || this.phone.text.isEmpty)
      Snack.showSnack(title: "Erro", message: "Preencha todos os campos!");
    else if (!this.email.text.contains('@'))
      Snack.showSnack(title: "Erro", message: "E-mail inválido!");
    else if (this.phone.text.length != 11)
      Snack.showSnack(title: "Erro", message: "Telefone inválido!");
    else {
      Map<String, String> data = {
        "email": this.email.text,
        "senha": this.password.text,
        "nome": this.name.text,
        "telefone": this.phone.text,
      };
      http.post(
        "${Api.address}/usuarios",
        body: json.encode(data),
        headers: {"Content-Type": "application/json"},
      ).then((res) async {
        if (res.statusCode == 201) {
          this.email.text = "";
          this.password.text = "";

          await Session.login(json.decode(res.body)['usuario']);
          await Session.setToken(json.decode(res.body)['token']);

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeView()), (route) => false);
        } else if (res.statusCode == 400) {
          var erro = json.decode(res.body)['error'];
          if (erro == "email_em_uso") Snack.showSnack(title: "Erro", message: "E-mail já cadastrado!");
        }
      });
    }
  }
}
