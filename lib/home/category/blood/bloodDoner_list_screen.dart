import 'package:flutter/material.dart';

class BloodDonersListScreen extends StatefulWidget {
  const BloodDonersListScreen({Key? key}) : super(key: key);

  @override
  _BloodDonersListScreenState createState() => _BloodDonersListScreenState();
}

class _BloodDonersListScreenState extends State<BloodDonersListScreen> {
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
