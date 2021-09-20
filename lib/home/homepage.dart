import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/home/home_navigation/homepage_navigator.dart';
import 'package:msf/home/horizontal_hospital_listView.dart';

import 'home_category_view.dart';

class HomePage extends StatefulWidget {
  static const PATH = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ..._buildAllCategories(context),
                SizedBox(height: 24),
                ..._buildNearbyHospitals(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomepageNavigator(),
    );
  }

  List<Widget> _buildAllCategories(BuildContext context) {
    return [
      SizedBox(height: 12),
      Text(
        'Category',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 12),
      HomeCategoryView()
    ];
  }

  List<Widget> _buildNearbyHospitals(BuildContext context) {
    return [
      Text(
        'Nearby Hospitals',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      HorizontalHospitalListView(),
    ];
  }
}
