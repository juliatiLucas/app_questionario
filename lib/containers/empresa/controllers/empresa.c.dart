
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';
import '../models/empresa.m.dart';

class EmpresaController extends GetxController {
  static EmpresaController get to => Get.find();
  TextEditingController pesquisa = TextEditingController();
  Rx<List<EmpresaModel>> empresas = Rx<List<EmpresaModel>>();
  Dio dio = Dio();

  void pesquisar() async {
    if (this.pesquisa.text.isEmpty) return;
    var token = await Session.getToken();
    List<EmpresaModel> empresas = [];

    dio
        .post(
      "${Api.address}/empresas/filtrar",
      data: {"empresa": this.pesquisa.text.trim()},
      options: Options(headers: token),
    )
        .then((res) {
      if (res.statusCode == 200) {
        for (var e in res.data) empresas.add(new EmpresaModel.fromJson(e));
        this.empresas.value = empresas;
        update();

        this.pesquisa.text = "";
        Get.back();
      }
    });
  }
}
