import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snack {
  static void showSnack({String title, String message}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(title, message,
          backgroundColor: Colors.white,
          borderRadius: 2,
          margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          messageText: Opacity(opacity: 0.87, child: Text(message)),
          animationDuration: Duration(milliseconds: 200));
    }
  }
}
