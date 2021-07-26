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
      appBar: AppBar(
        backgroundColor: Color(0xff26496a),
      ),

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
                        Image.asset(
                          'assets/images/medicine.png',
                          height: 48,
                          width: 48,
                        )),
                    _buildGridItem(
                        context,
                        'Hospital',
                        Image.asset(
                          'assets/images/hospital2.png',
                          height: 48,
                          width: 48,
                        )),
                    _buildGridItem(
                        context,
                        'Doctor',
                        Image.asset(
                          'assets/images/heart_shape.png',
                          height: 48,
                          width: 48,
                        )),
                    _buildGridItem(
                        context,
                        'Blood',
                        Image.asset(
                          'assets/images/blood1.png',
                          height: 48,
                          width: 48,
                        )),
                    _buildGridItem(
                        context,
                        'Oxygen',
                        Image.asset(
                          'assets/images/oxygen.png',
                          height: 48,
                          width: 48,
                        )),
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

  Widget _buildGridItem(BuildContext context, String title, Widget image) {
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
          color: Color(0xffffab91
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: image,
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

