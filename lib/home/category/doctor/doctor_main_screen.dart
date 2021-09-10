import 'package:flutter/material.dart';
import 'package:msf/widgets/horizontal_list_view.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  _DoctorMainScreenState createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Doctor'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("Doctor Screen"),
            HorizontalListView(),
          ],
        ),
      ),
    );
  }
}
