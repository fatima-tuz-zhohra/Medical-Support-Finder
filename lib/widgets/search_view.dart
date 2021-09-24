import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  final void Function(String) onTextChange;

  SearchView({required this.onTextChange});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      height: 64,
      width: size.width * 0.95,
      child: TextFormField(
        onChanged: onTextChange,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Search...',
            border: InputBorder.none),
        //onEditingComplete: () {},
      ),
    );
  }
}
