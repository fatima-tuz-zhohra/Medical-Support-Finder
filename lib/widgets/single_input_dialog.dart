import 'package:flutter/material.dart';

class SingleInputDialog extends StatelessWidget {
  final textController = TextEditingController();
  final String hint;

  SingleInputDialog({Key? key, this.hint = 'Enter text'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(hint),
      content: TextField(
        controller: textController,
        decoration:
            InputDecoration(hintText: hint, border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, textController.text),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
