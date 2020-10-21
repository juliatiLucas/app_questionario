
class CategoriaModel {
  int id;
  String nome;

  CategoriaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
  }
}
