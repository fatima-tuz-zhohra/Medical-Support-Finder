import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/home/homepage_navigator.dart';

import 'medicine.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12,),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child:
              Text(
                'Here Is Everything',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins',
                fontSize: 20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 2,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    _buildGridItem(
                        context,
                        'Medicine',
                          'assets/images/medicine.png',
                          ),
                    _buildGridItem(
                        context,
                        'Hospital',
                          'assets/images/hospital2.png',
                    ),
                    _buildGridItem(
                        context,
                        'Doctor',
                          'assets/images/heart_shape.png',
                         ),
                    _buildGridItem(
                        context,
                        'Blood',
                          'assets/images/blood1.png',
                         ),
                    _buildGridItem(
                        context,
                        'Oxygen',
                          'assets/images/oxygen.png',
                          ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      bottomNavigationBar: HomepageNavigator(),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String image) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Medicine();
        }));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xff80cbc4
          ),
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
              style: TextStyle(fontFamily: 'Italy',
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

