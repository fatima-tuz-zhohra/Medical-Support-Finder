import 'dart:math';

import 'package:flutter/material.dart';
import 'package:msf/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Home';
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: Icon(Icons.settings),
        ),
        body:
        Padding(padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text('gbb'),
              const
              SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation ==
                        Orientation.landscape
                        ? 3
                        : 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: (2 / 1),
                  ),
                  itemBuilder: (
                      context,
                      index,
                      ) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return MyHomePage(title: 'dfgdfg');
                            }));
                      },
                      child: Container(
                        color: RandomColorModel().getColor(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add_a_photo),
                            Text('home',
                                style:
                                TextStyle(fontSize: 18, color: Colors.black),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        )


        /*GridView.count(crossAxisCount: 2,
     children: List.generate(6,(index){
       return Container(
         color: Colors.blueGrey,
         child: Center(
             child:Column(
                 children:[
                     Icon(
                       Icons.add_a_photo_outlined,
                       size: 24,
                       color: Colors.black87,
                     ),
                     Text(
                       'Item $index',
                       style: Theme.of(context).textTheme.headline5,
                     ),
                 ]
             )
         )
       );

     }
     ),),*/
        );
  }
}

class RandomColorModel {
  Random random = Random();

  Color getColor() {
    return Color.fromARGB(random.nextInt(300), random.nextInt(300),
        random.nextInt(300), random.nextInt(300));
  }
}
