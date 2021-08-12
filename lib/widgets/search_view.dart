import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final void Function(String) onTextChange;

  SearchView({ required this.onTextChange });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        onChanged: onTextChange,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.saved_search),
          hintText: 'For Search ',
        ),
      ),
    );
  }
}
