import 'package:flutter/material.dart';

class SingleInputDialog extends StatefulWidget {
  final String hint;
  final String? validation;

  SingleInputDialog({Key? key, this.hint = 'Enter text', this.validation}) : super(key: key);

  @override
  _SingleInputDialogState createState() => _SingleInputDialogState();
}

class _SingleInputDialogState extends State<SingleInputDialog> {
  final textController = TextEditingController();

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.hint),
      content: TextField(
        onChanged: (input) {
          if(widget.validation != null) {
            _validateInput(widget.validation!, input);
          }
        },
        controller: textController,
        decoration: InputDecoration(
            labelText: widget.hint,
            errorText: _errorText,
            border: OutlineInputBorder()),
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

  void _validateInput(String validation, String input){
    final isValid = RegExp(validation).hasMatch(input);
    if (isValid) {
      setState(() {
        _errorText = null;
      });
    } else {
      setState(() {
        _errorText = 'Invalid Input';
      });
    }
  }
}
