import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/home/category/blood/blood_main_screen.dart';
import 'package:msf/home/category/doctor/doctor_main_screen.dart';
import 'package:msf/home/category/hospital/hospital_main_screen.dart';
import 'package:msf/home/category/medicine/medicine_main_screen.dart';
import 'package:msf/home/category/oxygen/oxygen_main_screen.dart';
import 'package:msf/home/home_navigation/homepage_navigator.dart';
import 'package:msf/widgets/grid_item.dart';
import 'package:msf/widgets/horizontal_hospital_listView.dart';

class HomePage extends StatefulWidget {
  static const PATH = "/home";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(
                  'Home',
                  style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                HomeCategory(),

                SizedBox(height: 24),
                Text('NearBy Hospital For You', style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),),
                SizedBox(height: 8),
                HorizontalHospitalListView(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: HomepageNavigator(),
    );
  }

  Widget HomeCategory() {
    return GridView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 2,
      ),
      scrollDirection: Axis.vertical,
      children: [
        GridItemView(
          title: 'Medicine',
          image: 'assets/images/medicine.png',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MedicineMainScreen();
            }));
          },
        ),
        GridItemView(
          title: 'Hospital',
          image: 'assets/images/hospital2.png',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HospitalMainScreen();
            }));
          },
        ),
        GridItemView(
          title: 'Doctor',
          image: 'assets/images/heart_shape.png',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DoctorMainScreen();
            }));
          },
        ),
        GridItemView(
          title: 'Blood',
          image: 'assets/images/blood1.png',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BloodMainScreen();
            }));
          },
        ),
        GridItemView(
          title: 'Oxygen',
          image: 'assets/images/oxygen.png',
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OxygenMainScreen();
            }));
          },
        ),
      ],
    );
  }
}
