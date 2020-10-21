
class OpcaoModel {
  int id;
  String opcao;

  OpcaoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    opcao = json['opcao'];
  }
}
