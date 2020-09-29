import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/perfil.c.dart';
import 'package:google_fonts/google_fonts.dart';
// import '../models/usuario.m.dart';

class PerfilView extends StatelessWidget {
  final int userId;
  PerfilView({this.userId});

  void mudarFoto(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              height: 300,
              child: Column(
                children: [
                  Text(
                    'Mudar foto',
                    style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ctr.usuario.value != null
                                    ? GestureDetector(
                                        onTap: ctr.usuario.value.self ? () => this.mudarFoto(context) : null,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.purple.withOpacity(0.4),
                                          radius: 50,
                                        ))
                                    : SizedBox(),
                                ctr.usuario.value != null
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
                                      // ListView.builder(itemBuilder: null)
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
