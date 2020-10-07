import '../../perfil/models/usuario.m.dart';
import './categoria.m.dart';

class EmpresaModel {
  int id;
  String nome;
  String email;
  String telefone;
  CategoriaModel categoria;

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = utf8convert(json['nome']);
    email = json['email'];
    telefone = json['telefone'];
    categoria = json['categoria'] != null ? CategoriaModel.fromJson(json['categoria']) : null;
  }
}
