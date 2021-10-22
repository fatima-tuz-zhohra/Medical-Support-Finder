import 'package:flutter/material.dart';

class EditInputField extends StatelessWidget {
  EditInputField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.leading = const Icon(Icons.edit),
    this.maxline = 1,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final Widget? leading;
  final int maxline;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.16),
      child: TextFormField(
        maxLines: maxline,
        controller: this.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: leading,
          labelText: hintText,
        ),
        validator: validator,
      ),
    );
  }
}
