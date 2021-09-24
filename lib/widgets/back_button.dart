import 'package:flutter/material.dart';

class MsfBackButton extends StatelessWidget {
  const MsfBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22))),
        margin: EdgeInsets.all(0),
        elevation: 0,
        color: Colors.orange.shade500,
        child: SizedBox(
            height: 44,
            width: 58,
            child: Icon(Icons.arrow_back_ios)),
      ),
    );
  }
}
