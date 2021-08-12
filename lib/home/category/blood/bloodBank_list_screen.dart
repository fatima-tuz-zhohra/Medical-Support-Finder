import 'package:flutter/material.dart';

class BloodBankListScreen extends StatefulWidget {
  const BloodBankListScreen({Key? key}) : super(key: key);

  @override
  _BloodBankListScreenState createState() => _BloodBankListScreenState();
}

class _BloodBankListScreenState extends State<BloodBankListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Bank'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Blood Bank Screen"),

              ],
            )),
      ),
    );
  }
}
