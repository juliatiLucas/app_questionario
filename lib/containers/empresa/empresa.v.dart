import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/controllers/home.c.dart';
import 'models/empresa.m.dart';
import 'widgets/empresa_card.dart';

class EmpresaView extends StatelessWidget {
  final HomeController ctr;
  EmpresaView({this.ctr});

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
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('Empresas', style: GoogleFonts.dmSans(fontWeight: FontWeight.bold, fontSize: 18))),
            ),
            if (!ctr.empresas.value.isNullOrBlank)
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: ctr.empresas.value.length,
                    itemBuilder: (_, index) {
                      EmpresaModel empresa = ctr.empresas.value[index];
                      return EmpresaCard(empresa: empresa);
                    }),
              )
            else
              Padding(padding: EdgeInsets.only(top: 20), child: Center(child: Text('Nenhuma empresa encontrada.'))),
          ],
        ),
      ),
    );
  }
}
