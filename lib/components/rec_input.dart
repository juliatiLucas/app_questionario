import 'package:flutter/material.dart';

class RecInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  RecInput({this.controller, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3, bottom: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10)),
      ),
    );
  }
}
