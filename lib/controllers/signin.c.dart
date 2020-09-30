import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../utils/session.dart';
import '../utils/api.dart';
import '../components/snack.dart';
import '../views/home.v.dart';

class SignInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void login(BuildContext context) async {
    if (this.email.text.isEmpty || this.password.text.isEmpty) {
      Snack.showSnack(title: "Erro", message: "E-mail e senha não podem ser nulos!");
    } else if (!this.email.text.contains('@')) {
      Snack.showSnack(title: "Erro", message: "E-mail inválido!");
    } else {
      Map<String, String> data = {
        "email": this.email.text.trim(),
        "senha": this.password.text,
      };
      http.post(
        "${Api.address}/usuarios/login",
        body: json.encode(data),
        headers: {"Content-Type": "application/json"},
      ).then((res) async {
        if (res.statusCode == 200) {
          this.email.text = "";
          this.password.text = "";

          await Session.login(json.decode(res.body)['usuario']);
          await Session.setToken(json.decode(res.body)['token']);

          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeView()), (route) => false);
        } else if (res.statusCode == 400) {
          var erro = json.decode(res.body)['error'];
          if (erro == "usuario_nao_existe")
            Snack.showSnack(title: "Erro", message: "Usuário não encontrado!");
          else if (erro == "senha_incorreta") Snack.showSnack(title: "Erro", message: "Senha incorreta!");
        }
      });
    }
  }
}
