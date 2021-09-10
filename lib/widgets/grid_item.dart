import 'package:flutter/material.dart';

class GridItemView extends StatelessWidget {
  GridItemView({Key? key,  required this.title, required this.image, required this.onTap}) : super(key: key);

  String title;
  String image;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff80cbc4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white70,
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Italy',
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
