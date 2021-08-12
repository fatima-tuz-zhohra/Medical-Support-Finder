import 'package:flutter/material.dart';
import 'package:msf/data/model/medicine_item.dart';

class MedicineDetails extends StatelessWidget {
  MedicineDetails(this.medicineItem, {Key? key}) : super(key: key);
  MedicineItem medicineItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(medicineItem.name),
      ),
      body: Padding(
          padding: EdgeInsets.all(12),
          child: Text(medicineItem.description)),
    );
  }
}
