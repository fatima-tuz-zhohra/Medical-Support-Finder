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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                'Hello ${userBloc.appUser?.name}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Poppins',
                    fontSize: 20),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: GridView(
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MedicineMainScreen();
                        }));
                      },
                    ),
                    GridItemView(
                      title: 'Hospital',
                      image: 'assets/images/hospital2.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return HospitalMainScreen();
                        }));
                      },
                    ),
                    GridItemView(
                      title: 'Doctor',
                      image: 'assets/images/heart_shape.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DoctorMainScreen();
                        }));
                      },
                    ),
                    GridItemView(
                      title: 'Blood',
                      image: 'assets/images/blood1.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BloodMainScreen();
                        }));
                      },
                    ),
                    GridItemView(
                      title: 'Oxygen',
                      image: 'assets/images/oxygen.png',
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return OxygenMainScreen();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: HomepageNavigator(),
    );
  }
}
