import 'opcao.m.dart';

class RespostaUsuario {
  int pergunta;
  int usuario;
  OpcaoModel opcao;
  String resposta;

  RespostaUsuario({this.pergunta, this.usuario, this.opcao, this.resposta = ""});
}
