import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {Key? key,
      required this.icon,
      required this.hintText,
      required this.controller,
      })
      : super(key: key);

  Widget icon;
  String hintText;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
