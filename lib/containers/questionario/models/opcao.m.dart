import '../../perfil/models/usuario.m.dart';

class OpcaoModel {
  int id;
  String opcao;

  OpcaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opcao = utf8convert(json['opcao']);
  }
}
