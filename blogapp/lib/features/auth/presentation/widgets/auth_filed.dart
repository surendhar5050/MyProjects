import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool obsuretext;

  const AuthField(
      {super.key,
      this.obsuretext = false,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscuringCharacter: "*",
      obscureText: obsuretext,
    );
  }
}
