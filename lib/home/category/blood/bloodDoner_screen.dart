import 'package:flutter/material.dart';

class BloodDonersScreen extends StatefulWidget {
  const BloodDonersScreen({Key? key}) : super(key: key);

  @override
  _BloodDonersScreenState createState() => _BloodDonersScreenState();
}

class _BloodDonersScreenState extends State<BloodDonersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Doners'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Blood Doners Screen"),

              ],
            )),
      ),
    );
  }
}
