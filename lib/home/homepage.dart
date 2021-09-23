import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/category/blood/all_blood_request.dart';
import 'package:msf/category/blood/bloodBank_screen.dart';
import 'package:msf/category/blood/my_blood_request.dart';
import 'package:msf/category/hospital/hospital_main_screen.dart';
import 'package:msf/home/home_navigation/homepage_navigator.dart';
import 'package:msf/home/nearby_hospitals_view.dart';
import 'package:msf/home/top_blood_banks_view.dart';

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
                ..._buildMyBloodRequest(context),
                SizedBox(height: 24),
                ..._buildTopBloodBanks(context),
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

  List<Widget> _buildMyBloodRequest(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'My Blood Request',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AllBloodRequest.PATH);
              },
              child: Text('View All'))
        ],
      ),
      SizedBox(height: 8),
     MyBloodRequest(),
    ];
  }

  List<Widget> _buildTopBloodBanks(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Blood Banks',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, BloodBankScreen.PATH);
              },
              child: Text('View All'))
        ],
      ),
      SizedBox(height: 8),
      TopBloodBanksListView(),
    ];
  }

  List<Widget> _buildNearbyHospitals(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Nearby Hospitals',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, HospitalMainScreen.PATH);
              },
              child: Text('View All'))
        ],
      ),
      SizedBox(height: 8),
      HorizontalHospitalListView(),
    ];
  }
}
