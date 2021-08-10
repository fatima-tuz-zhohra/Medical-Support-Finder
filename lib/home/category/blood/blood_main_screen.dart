import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Blood Screen"),
              ],
            )),
      ),
    );
  }
}
