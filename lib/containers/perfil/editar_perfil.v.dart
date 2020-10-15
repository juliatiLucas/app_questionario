import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/components/rec_input.dart';
import 'controllers/editar_perfil.c.dart';
import 'models/usuario.m.dart';

class EditarPerfilView extends StatefulWidget {
  final UsuarioModel usuario;
  EditarPerfilView({this.usuario});

  @override
  _EditarPerfilViewState createState() => _EditarPerfilViewState();
}

class _EditarPerfilViewState extends State<EditarPerfilView> {
  EditarPerfilController _editarPerfilController = Get.put(EditarPerfilController());

  @override
  void initState() {
    super.initState();
    _editarPerfilController.nome.text = widget.usuario.nome;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height / 3.5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GetBuilder<EditarPerfilController>(
          init: Get.put(EditarPerfilController()),
          builder: (ctr) => SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              width: size.width,
              height: 250,
              child: Material(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.close), onPressed: Navigator.of(context).pop),
                          Text(
                            "Editar",
                            style: GoogleFonts.dmSans(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(icon: Icon(Icons.done), onPressed: () => ctr.editar(widget.usuario.id)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text('Nome'),
                      RecInput(controller: ctr.nome),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
