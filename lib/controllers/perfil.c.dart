import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/session.dart';
import '../utils/api.dart';
import '../models/usuario.m.dart';

class PerfilController extends GetxController {
  static PerfilController get to => Get.find();
  Rx<UsuarioModel> usuario = Rx<UsuarioModel>();

  void getUserInfo(int userId) async {
    UsuarioModel usuario;
    var token = await Session.getToken();
    http.get("${Api.address}/usuarios/$userId", headers: token).then((res) async {
      if (res.statusCode == 200) {
        usuario = new UsuarioModel.fromJson(json.decode(res.body));
        usuario.self = (await Session.getUserInfo())['id'] == usuario.id;
        this.usuario.value = usuario;
        update();
      }
    });
  }
}
