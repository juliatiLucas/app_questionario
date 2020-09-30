import 'package:flutter/material.dart';

class RecInput extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String) onChanged;
  final bool bottomPadding;
  final String hintText;
  final bool autoFocus;

  RecInput(
      {this.controller,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.hintText,
      this.bottomPadding = true,
      this.autoFocus = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3, bottom: bottomPadding ? 15 : 0),
      child: TextField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        autofocus: autoFocus,
        decoration: InputDecoration(
            fillColor: Colors.grey[200],
            filled: true,
            hintText: hintText,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 10)),
      ),
    );
  }
}
