import 'package:flutter/material.dart';
import 'package:get/get.dart';
import './models/empresa.m.dart';

class EmpresaView extends StatelessWidget {
  final EmpresaModel empresa;
  EmpresaView({this.empresa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [Text(empresa.nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))],
          ),
        ),
      ),
    );
  }
}
