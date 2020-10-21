class UsuarioModel {
  int id;
  String nome;
  String email;
  String imagem;
  bool self;

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    imagem = json['imagem'] ?? null;
    email = json['email'];
  }

  set setSelf(bool self) {
    this.self = self;
  }
}
