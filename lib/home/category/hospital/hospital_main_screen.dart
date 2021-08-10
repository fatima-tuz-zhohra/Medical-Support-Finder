import 'package:flutter/material.dart';

class HospitalMainScreen extends StatefulWidget {
  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  _HospitalMainScreenState createState() => _HospitalMainScreenState();
}

class _HospitalMainScreenState extends State<HospitalMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hospital'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hospital Screen"),
              ],
            )),
      ),
    );
  }
}
