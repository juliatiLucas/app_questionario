import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as httpParser;

import '../../../utils/api.dart';
import '../../../utils/session.dart';
import '../../questionario/models/resposta.m.dart';
import '../models/usuario.m.dart';

class PerfilController extends GetxController {
  Dio dio = Dio();
  static PerfilController get to => Get.find();
  Rx<UsuarioModel> usuario = Rx<UsuarioModel>();
  Rx<List<RespostaModel>> respostas = Rx<List<RespostaModel>>();
  Rx<File> imagem = Rx<File>();

  void setImagem(File file) {
    imagem.value = file;
    update();
  }

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

  void atualizarImagem() async {
    var token = await Session.getToken();
    var userInfo = await Session.getUserInfo();

    String ext = this.imagem.value.path.split('.').last;
    FormData data = new FormData.fromMap({
      "imagem": await MultipartFile.fromFile(this.imagem.value.path,
          filename: DateTime.now().millisecondsSinceEpoch.toString() + ".$ext",
          contentType: httpParser.MediaType('image', (ext == 'jpg' || ext == 'jpeg') ? 'jpeg' : 'png'))
    });

    dio.put("${Api.address}/usuarios/${userInfo['id']}", data: data, options: Options(headers: token)).then((res) {
      if (res.statusCode == 200) {
        Get.back();
        this.getUserInfo(userInfo['id']);
      }
    });
  }
}
