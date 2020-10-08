import '../../perfil/models/usuario.m.dart';
import '../../questionario/models/categoria.m.dart';
import '../../questionario/models/questionario.m.dart';

class EmpresaModel {
  int id;
  String nome;
  String email;
  String telefone;
  CategoriaModel categoria;
  List<QuestionarioModel> questionarios;

  EmpresaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = utf8convert(json['nome']);
    email = json['email'];
    telefone = json['telefone'];
    categoria = json['categoria'] != null ? CategoriaModel.fromJson(json['categoria']) : null;
    if (json['questionarios'] != null) {
      List<QuestionarioModel> questionarios = [];
      for (var q in json['questionarios']) questionarios.add(new QuestionarioModel.fromJson(q));

      this.questionarios = questionarios;
    }
  }
}
