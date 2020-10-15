import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/components/snack.dart';
import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';
import 'perfil.c.dart';

class EditarPerfilController extends GetxController {
  static EditarPerfilController get to => Get.find();
  PerfilController _perfilController = Get.put(PerfilController());
  TextEditingController nome = TextEditingController();
  Dio dio = Dio();

  void editar(int usuarioId) async {
    if (this.nome.text.isEmpty)
      Snack.showSnack(title: "Erro", message: "Você não pode deixar seu nome vazio!");
    else {
      var token = await Session.getToken();
      dio
          .put(
        "${Api.address}/usuarios/$usuarioId",
        data: {"nome": this.nome.text},
        options: Options(headers: token),
      )
          .then((res) {
        if (res.statusCode == 200) _perfilController.getUserInfo(usuarioId);
      });
    }
  }
}
