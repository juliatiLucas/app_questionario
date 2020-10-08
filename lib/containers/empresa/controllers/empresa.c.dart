import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/api.dart';
import '../../../core/utils/session.dart';

class EmpresaController extends GetxController {
  static EmpresaController get to => Get.find();
  TextEditingController pesquisa = TextEditingController();

  void pesquisar() {
    if (this.pesquisa.text.isEmpty) return;


    
  }
}
