import 'package:flutter/material.dart';

class MyBloodRequest extends StatelessWidget {
  const MyBloodRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      final List<String> entries = <String>['A', 'B', 'C','D'];
      return Container(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              shape: RoundedRectangleBorder( borderRadius:BorderRadius.circular(8)),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundColor: Colors.brown.shade800,
                      child: Center(child: Text('B+')),
                    ),
                     SizedBox(width: 12),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Contact No'),

                        Text('Status'),
                      ],
                    ),
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
}
