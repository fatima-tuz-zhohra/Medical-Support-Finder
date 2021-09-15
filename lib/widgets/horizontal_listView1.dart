import 'package:flutter/material.dart';

class HorizontalListView1 extends StatelessWidget {
  const HorizontalListView1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> entries = <String>['A', 'B', 'C','D'];
    return Container(
      height: 70,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              shape: RoundedRectangleBorder( borderRadius:BorderRadius.circular(8)),
              child: Container(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      //radius: 40,
                      backgroundColor: Colors.white70,
                      backgroundImage: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    ),
                    const SizedBox(width: 12),
                    Text('Name'),
                  ],
                ),
              ),
            );
          },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
