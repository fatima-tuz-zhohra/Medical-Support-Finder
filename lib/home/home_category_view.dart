import 'package:flutter/material.dart';
import 'package:msf/category/blood/bloodDonor_screen.dart';
import 'package:msf/category/doctor/doctor_main_screen.dart';
import 'package:msf/category/hospital/hospital_main_screen.dart';
import 'package:msf/category/medicine/medicine_main_screen.dart';
import 'package:msf/category/oxygen/oxygen_main_screen.dart';
import 'package:msf/widgets/grid_item.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
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
            title: 'Blood Donors',
            image: 'assets/images/blood1.png',
            onTap: () {
              Navigator.pushNamed(context, BloodDonorsScreen.PATH);
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
      ),
    );
  }
}
