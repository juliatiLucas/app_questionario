import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/components/rec_input.dart';
import '../../empresa/models/empresa.m.dart';
import '../../empresa/widgets/empresa_card.dart';
import '../../home/controllers/home.c.dart';
import '../controllers/empresa.c.dart';

class EmpresaPage extends StatefulWidget {
  final HomeController ctr;
  EmpresaPage({this.ctr});

  @override
  _EmpresaPageState createState() => _EmpresaPageState();
}

class _EmpresaPageState extends State<EmpresaPage> {
  EmpresaController _empresaController = Get.put(EmpresaController());

  void pesquisaModal() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Container(
                height: 135,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    RecInput(controller: _empresaController.pesquisa, hintText: "Nome da empresa"),
                    FlatButton(
                        onPressed: _empresaController.pesquisar,
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),
                        )),
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 0, bottom: 12, left: 14, right: 14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(2)), boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            color: Colors.black.withOpacity(0.3),
          )
        ]),
        height: MediaQuery.of(context).size.width / 0.85,
        child: Material(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Opacity(
                opacity: 0.82,
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Empresas', style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 18)),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: IconButton(icon: Icon(Icons.search), onPressed: this.pesquisaModal)),
                ]),
              ),
              if (widget.ctr.empresas.value != null)
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: widget.ctr.empresas.value.length,
                      itemBuilder: (_, index) {
                        EmpresaModel empresa = widget.ctr.empresas.value[index];
                        return EmpresaCard(empresa: empresa);
                      }),
                )
              else
                Center(child: Text('Nenhuma empresa encontrada.')),
            ],
          ),
        ));
  }
}
