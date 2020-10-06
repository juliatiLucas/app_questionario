import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../questionario/models/resposta.m.dart';
import '../questionario/widgets/resposta_card.dart';
import 'controllers/perfil.c.dart';

class PerfilView extends StatelessWidget {
  final int userId;
  final PerfilController _perfilController = Get.put(PerfilController());
  PerfilView({this.userId});

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
                height: !ctr.imagem.isNullOrBlank ? 395 : 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !ctr.imagem.value.isNullOrBlank
                        ? Container(
                            height: 150,
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: FileImage(ctr.imagem.value),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(height: 20),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Column(
                          children: [
                            SizedBox(height: 15),
                            FlatButton(
                                onPressed: () async {
                                  final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                  if (!pickedFile.isNull) file = File(pickedFile?.path);
                                  ctr.setImagem(file);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.filter),
                                      SizedBox(width: 10),
                                      Text(
                                        'Galeria',
                                        style: TextStyle(fontSize: 20),
                                      )
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt),
                                      SizedBox(width: 10),
                                      Text(
                                        'Câmera',
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                )),
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 18),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                                      FlatButton(child: Text('CANCELAR'), onPressed: Get.back),
                                      FlatButton(
                                          child: Text('CONCLUÍDO'),
                                          onPressed: ctr.imagem.value.isNull ? null : ctr.atualizarImagem)
                                    ])),
                              ),
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
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
                    child: SingleChildScrollView(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: Navigator.of(context).pop,
                          color: Colors.white,
                        ),
                        Text(
                          "Perfil",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                !ctr.usuario.value.isNullOrBlank
                                    ? ctr.usuario.value.imagem.isNullOrBlank
                                        ? GestureDetector(
                                            onTap: ctr.usuario.value.self ? () => this.mudarFoto(context) : null,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.purple.withOpacity(0.4),
                                              radius: 50,
                                            ))
                                        : Container(
                                            height: 100,
                                            width: 100,
                                            child: GestureDetector(
                                                onTap: ctr.usuario.value.self ? () => this.mudarFoto(context) : null,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.purple.withOpacity(0.4),
                                                  radius: 50,
                                                  backgroundImage: NetworkImage(ctr.usuario.value.imagem),
                                                )),
                                          )
                                    : SizedBox(),
                                !ctr.usuario.value.isNullOrBlank
                                    ? Opacity(
                                        opacity: 0.85,
                                        child: Column(children: [
                                          Text(
                                            ctr.usuario.value.nome,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ctr.usuario.value.email,
                                            style: TextStyle(color: Colors.white, fontSize: 16),
                                          ),
                                        ]))
                                    : Padding(
                                        padding: EdgeInsets.symmetric(vertical: 25, horizontal: 32),
                                        child: LinearProgressIndicator()),
                                SizedBox(height: 15),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  height: MediaQuery.of(context).size.height * 0.62,
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
                                      else
                                        SizedBox()
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                )),
      ),
    );
  }
}
