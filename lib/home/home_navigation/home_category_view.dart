import 'package:flutter/material.dart';
import 'package:msf/home/category/blood/blood_main_screen.dart';
import 'package:msf/home/category/doctor/doctor_main_screen.dart';
import 'package:msf/home/category/hospital/hospital_main_screen.dart';
import 'package:msf/home/category/medicine/medicine_main_screen.dart';
import 'package:msf/home/category/oxygen/oxygen_main_screen.dart';
import 'package:msf/widgets/grid_item.dart';

class HomeCategoryView extends StatelessWidget {
  const HomeCategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
