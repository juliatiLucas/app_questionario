import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

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
