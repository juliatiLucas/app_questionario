import '../../perfil/models/usuario.m.dart';

class EmpresaModel {
  int id;
  String nome;
  String email;
  String telefone;

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = utf8convert(json['nome']);
    email = json['email'];
    telefone = json['telefone'];
  }
}
