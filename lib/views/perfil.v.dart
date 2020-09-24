import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/perfil.c.dart';
// import '../models/usuario.m.dart';

class PerfilView extends StatelessWidget {
  final int userId;
  PerfilView({this.userId});

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
                      SizedBox(height: 20),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.purple.withOpacity(0.4),
                                radius: 80,
                              ),
                              ctr.usuario.value != null
                                  ? Opacity(
                                      opacity: 0.85,
                                      child: Text(
                                        ctr.usuario.value.nome,
                                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                )),
      ),
    );
  }
}
