import './opcao.m.dart';

class Resposta {
  int pergunta;
  int usuario;
  OpcaoModel opcao;
  String resposta;

  Resposta({this.pergunta, this.usuario, this.opcao, this.resposta = ""});
}
