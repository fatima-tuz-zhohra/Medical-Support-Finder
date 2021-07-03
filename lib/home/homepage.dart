import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                'Here Is Everything',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                  fontFamily: 'Poppins'
                ),
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
                        _buildGridItem(context, 'title',Icon(Icons.medical_services)),
                        _buildGridItem(context, 'title2',Icon(Icons.local_hospital_rounded)),
                        _buildGridItem(context, 'title3',Icon(Icons.bloodtype_rounded)),
                        _buildGridItem(context, 'title4',Icon(Icons.lock_clock)),
                        _buildGridItem(context, 'title5',Icon(Icons.local_hospital_rounded)),
                      ],
                    ),
                  ),
              )

          ],
        ),
      ),

    );
  }

  Widget _buildGridItem(BuildContext context, String title, Widget icon){
    return InkWell(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Medicine();
      }));
    },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFF8A583434),
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
              child: icon,
            ),
            Text(title,
              style: TextStyle(
                  fontFamily: 'Italy'
              ),)
          ],
        ),
      ),
    );
  }

}
