import 'package:flutter/material.dart';

class RecInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  RecInput({this.controller, this.obscureText = false, this.keyboardType = TextInputType.text, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3, bottom: 15),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 10)),
      ),
    );
  }
}
