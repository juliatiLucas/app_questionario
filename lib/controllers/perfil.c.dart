import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../utils/session.dart';
import '../utils/api.dart';
import '../models/usuario.m.dart';
import '../models/resposta.m.dart';

class PerfilController extends GetxController {
  static PerfilController get to => Get.find();
  Rx<UsuarioModel> usuario = Rx<UsuarioModel>();
  Rx<List<RespostaModel>> respostas = Rx<List<RespostaModel>>();

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

  void getRespostasUsuario(int userId) async {
    List<RespostaModel> respostas = [];
    var token = await Session.getToken();

    http.get("${Api.address}/respostas/usuarios/$userId", headers: token).then((res) {
      if (res.statusCode == 200) {
        for (var r in json.decode(res.body)) respostas.add(new RespostaModel.fromJson(r));

        this.respostas.value = respostas;
        update();
      }
    });
  }
}
