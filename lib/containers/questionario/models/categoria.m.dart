import '../../perfil/models/usuario.m.dart';

class CategoriaModel {
  int id;
  String nome;

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = utf8convert(json['nome']);
  }
}
