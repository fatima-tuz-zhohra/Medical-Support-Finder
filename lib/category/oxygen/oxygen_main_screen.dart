import 'package:flutter/material.dart';

class OxygenMainScreen extends StatefulWidget {
  const OxygenMainScreen({Key? key}) : super(key: key);

  @override
  _OxygenMainScreenState createState() => _OxygenMainScreenState();
}

class _OxygenMainScreenState extends State<OxygenMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Oxygen'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Oxygen Screen"),

              ],
            )),
      ),
    );
  }
}
