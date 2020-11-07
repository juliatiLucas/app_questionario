import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';
import '../../questionario/models/resposta.m.dart';
import '../models/usuario.m.dart';

class PerfilController extends GetxController {
  Dio dio = Dio();
  static PerfilController get to => Get.find();
  Rx<UsuarioModel> usuario = Rx<UsuarioModel>();
  Rx<List<RespostaModel>> respostas = Rx<List<RespostaModel>>();
  Rx<File> imagem = Rx<File>();
  Rx<String> nomeImagem = Rx<String>();
  Rx<bool> uploading = Rx<bool>(false);

  void setUploading(bool value) {
    this.uploading.value = value;
    update();
  }

  void setImagem(File file) {
    imagem.value = file;
    if (file == null)
      nomeImagem.value = null;
    else
      nomeImagem.value = file.path.split('/')[file.path.split('/').indexOf(file.path.split('/').last)];

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

    await Firebase.initializeApp();

    String ext = this.imagem.value.path.split('.').last;
    var storage = FirebaseStorage.instance;
    this.setUploading(true);
    storage.ref(DateTime.now().millisecondsSinceEpoch.toString() + ".$ext").putFile(this.imagem.value).then((snapshot) {
      snapshot.state;
      snapshot.ref.getDownloadURL().then((value) {
        var data = json.encode({"imagem": value});

        dio.put("${Api.address}/usuarios/${userInfo['id']}", data: data, options: Options(headers: token)).then((res) {
          this.setUploading(false);
          if (res.statusCode == 200) {
            Get.back();
            this.getUserInfo(userInfo['id']);
          }
        });
      });
    });

    this.setImagem(null);
  }
}
