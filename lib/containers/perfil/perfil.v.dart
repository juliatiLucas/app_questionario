import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../questionario/models/resposta.m.dart';
import '../questionario/widgets/resposta_card.dart';
import 'controllers/perfil.c.dart';
import 'editar_perfil.v.dart';
import 'models/usuario.m.dart';

class PerfilView extends StatelessWidget {
  PerfilView({this.userId});
  final int userId;

  void mudarFoto(BuildContext context) {
    final picker = ImagePicker();
    File file;
    Size size = MediaQuery.of(context).size;

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) => GetBuilder<PerfilController>(
              builder: (ctr) => Container(
                width: size.width,
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!ctr.imagem.value.isNullOrBlank)
                      Container(
                        width: size.width * 0.8,
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2))),
                        child: Text(
                            "${ctr.nomeImagem.value.length > 40 ? ctr.nomeImagem.value.substring(0, 40) : ctr.nomeImagem.value} Selecionada"),
                      ),
                    SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            ctr.setImagem(null);
                                            Get.back();
                                          }),
                                      IconButton(
                                          icon: Icon(Icons.check),
                                          onPressed: ctr.imagem.value.isNull ? null : ctr.atualizarImagem)
                                    ])),
                              ),
                              SizedBox(height: 20),
                              FlatButton(
                                  onPressed: () async {
                                    final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                    if (!pickedFile.isNull) file = File(pickedFile?.path);
                                    ctr.setImagem(file);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.filter, color: Theme.of(context).primaryColor),
                                        SizedBox(width: 10),
                                        Text(
                                          'Galeria',
                                          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),
                                        ),
                                      ],
                                    ),
                                  )),
                              FlatButton(
                                  onPressed: () async {
                                    final pickedFile = await picker.getImage(source: ImageSource.camera);
                                    if (!pickedFile.isNull) file = File(pickedFile?.path);
                                    ctr.setImagem(file);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt, color: Theme.of(context).primaryColor),
                                        SizedBox(width: 10),
                                        Text(
                                          'Câmera',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void editarPerfil(BuildContext context, UsuarioModel usuario) {
    showDialog(
      context: context,
      builder: (_) => EditarPerfilView(usuario: usuario),
    );
  }

  Widget gerarImagem(BuildContext context, PerfilController ctr) {
    NetworkImage imagem;

    try {
      imagem = NetworkImage(ctr.usuario.value.imagem);
    } catch (err) {
      imagem = null;
    }

    return Container(
      height: 100,
      width: 100,
      child: GestureDetector(
          onTap: ctr.usuario.value.self ? () => this.mudarFoto(context) : null,
          child: CircleAvatar(
            backgroundColor: Colors.purple.withOpacity(0.4),
            radius: 50,
            backgroundImage: imagem,
          )),
    );
  }

  Future<void> getData(BuildContext context, PerfilController ctr) async {
    ctr.getUserInfo(userId);
    ctr.getRespostasUsuario(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: GetBuilder<PerfilController>(
            initState: (_) {
              PerfilController.to.getUserInfo(userId);
              PerfilController.to.getRespostasUsuario(userId);
            },
            init: Get.put(PerfilController()),
            builder: (ctr) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: SafeArea(
                    child: RefreshIndicator(
                      onRefresh: () => this.getData(context, ctr),
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: Navigator.of(context).pop,
                            color: Colors.white,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Perfil",
                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                                onPressed: () => this.editarPerfil(context, ctr.usuario.value),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (!ctr.usuario.value.isNullOrBlank)
                                    if (ctr.usuario.value.imagem.isNullOrBlank)
                                      GestureDetector(
                                          onTap: ctr.usuario.value.self ? () => this.mudarFoto(context) : null,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.purple.withOpacity(0.4),
                                            radius: 50,
                                          ))
                                    else
                                      this.gerarImagem(context, ctr)
                                  else
                                    SizedBox(),
                                  if (!ctr.usuario.value.isNullOrBlank)
                                    Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Opacity(
                                          opacity: 0.85,
                                          child: Column(children: [
                                            Text(
                                              ctr.usuario.value.nome,
                                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              ctr.usuario.value.email,
                                              style: TextStyle(color: Colors.white, fontSize: 16),
                                            ),
                                          ])),
                                    )
                                  else
                                    Padding(
                                        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 32),
                                        child: LinearProgressIndicator()),
                                  SizedBox(height: 15),
                                  if (!ctr.respostas.value.isNull)
                                    if (ctr.respostas.value.length > 0)
                                      AnimatedOpacity(
                                          opacity: !ctr.respostas.value.isNull ? 1 : 0,
                                          duration: Duration(milliseconds: 500),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                            height: MediaQuery.of(context).size.height * 0.62,
                                            width: MediaQuery.of(context).size.width,
                                            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(3)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(0, 2),
                                                    blurRadius: 2,
                                                    color: Colors.black.withOpacity(0.3),
                                                  )
                                                ]),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Respostas do usuário',
                                                  style: GoogleFonts.dmSans(fontSize: 18, fontWeight: FontWeight.bold),
                                                ),
                                                SizedBox(height: 10),
                                                if (!ctr.respostas.value.isNullOrBlank)
                                                  Expanded(
                                                    child: ListView.builder(
                                                        itemCount: ctr.respostas.value.length,
                                                        itemBuilder: (_, index) {
                                                          RespostaModel resposta = ctr.respostas.value[index];
                                                          return RespostaCard(resposta: resposta);
                                                        }),
                                                  )
                                              ],
                                            ),
                                          )),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
