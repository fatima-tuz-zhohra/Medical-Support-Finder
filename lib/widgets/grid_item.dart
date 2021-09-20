import 'package:flutter/material.dart';

class GridItemView extends StatelessWidget {
  GridItemView({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  String title;
  String image;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
        margin: EdgeInsets.all(8),
        elevation: 4,
        child: Container(
          width: 110,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white70,
                backgroundImage: AssetImage(image),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
