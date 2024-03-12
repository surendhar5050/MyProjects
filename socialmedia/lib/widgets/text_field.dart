
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hinttext;
  final TextInputType textInputType;

  TextFieldInput(
      {super.key,
      required this.textEditingController,
       this.isPass=false,
      required this.hinttext,
      required this.textInputType});

  @override
  Widget build(BuildContext context) {
    final inputborder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hinttext,
          border: inputborder,
          enabledBorder: inputborder,
          focusedBorder: inputborder,
          filled: true,
          contentPadding: EdgeInsets.all(8.0)),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }
}
