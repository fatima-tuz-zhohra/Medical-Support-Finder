import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);

  Widget icon;
  String hintText;
  TextEditingController controller;
  String? Function(String? value)? validator;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.16),
      child: TextFormField(
        controller: this.controller,
        obscureText: this.obscureText,
        decoration: InputDecoration(
          prefixIcon: icon,
          labelText: hintText,
          border: OutlineInputBorder(),
        ),
        validator: this.validator,
      ),
    );
  }
}
