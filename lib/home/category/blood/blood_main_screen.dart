import 'package:flutter/material.dart';
import 'package:msf/home/category/blood/bloodBank_screen.dart';
import 'package:msf/home/category/blood/bloodDoner_screen.dart';
import 'package:msf/widgets/grid_item.dart';

class BloodMainScreen extends StatefulWidget {
  const BloodMainScreen({Key? key}) : super(key: key);

  @override
  _BloodMainScreenState createState() => _BloodMainScreenState();
}

class _BloodMainScreenState extends State<BloodMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
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
                        GridItemView(
                          title: 'Blood Bank',
                          image: 'assets/images/medicine.png',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return BloodBankScreen();
                                }));
                          },
                        ),
                        GridItemView(
                          title: 'Blood Doners',
                          image: 'assets/images/medicine.png',
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return BloodDonersScreen();
                                }));
                          },
                        ),
                      ]
                  ),
                )
            ),

          ],
      ),
      ),
    );
  }
}
