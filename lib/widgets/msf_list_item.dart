import 'package:flutter/material.dart';

class MsfListItem extends StatelessWidget {
  MsfListItem({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: this.child,
    );
  }
}
