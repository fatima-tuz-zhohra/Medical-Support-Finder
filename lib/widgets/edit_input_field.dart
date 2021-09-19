import 'package:flutter/material.dart';

class EditInputField extends StatelessWidget {
  EditInputField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  String hintText;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.16),
      child: Stack(children: [
        TextFormField(
          controller: this.controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
        ),
        Positioned(
          right: 12,
            bottom: 12,
            child: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.primary,
            ),
        )
      ]),
    );
  }
}
