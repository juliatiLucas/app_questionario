import 'dart:convert' show utf8;

String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

class OpcaoModel {
  int id;
  String opcao;

  OpcaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opcao = utf8convert(json['opcao']);
  }
}
