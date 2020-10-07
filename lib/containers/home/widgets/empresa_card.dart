import 'package:flutter/material.dart';

import '../../questionario/models/empresa.m.dart';

class EmpresaCard extends StatelessWidget {
  final EmpresaModel empresa;
  EmpresaCard({this.empresa});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      color: Colors.grey.withOpacity(0.12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            empresa.nome,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            "Categoria: ${empresa?.categoria?.nome}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          
        ],
      ),
    );
  }
}
