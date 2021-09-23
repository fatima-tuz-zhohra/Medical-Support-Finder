import 'package:flutter/material.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/horizontal_list_view_small.dart';
import 'package:msf/widgets/horizontal_list_view_big.dart';
import 'package:msf/widgets/search_view.dart';

class DoctorMainScreen extends StatefulWidget {
  const DoctorMainScreen({Key? key}) : super(key: key);

  @override
  _DoctorMainScreenState createState() => _DoctorMainScreenState();
}

class _DoctorMainScreenState extends State<DoctorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsfAppBar(title: 'Doctor'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                "Which type of Doctor you want?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 12),
              SearchView(
                onTextChange: (String) {},
              ),
              const SizedBox(height: 20),
              Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              HorizontalListViewSmall(),
              const SizedBox(height: 20),
              Text(
                "Doctors",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              HorizontalListViewBig(),
            ],
          ),
        ),
      ),
    );
  }
}
