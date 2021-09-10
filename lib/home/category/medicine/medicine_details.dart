import 'package:flutter/material.dart';
import 'package:msf/data/model/item/medicine_item.dart';

class MedicineDetails extends StatelessWidget {
  MedicineDetails(this.medicineItem, {Key? key}) : super(key: key);
  MedicineItem medicineItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(medicineItem.name ?? ''),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Generic: ${medicineItem.generic ?? ''}'),
            const SizedBox(height: 4,),

            Text('Company Name: ${medicineItem.companyName ?? ' '}'),
            const SizedBox(height: 4,),

            Text('Price: ${medicineItem.price} Taka'),
            const SizedBox(height: 4,),

            Text('Description: ${medicineItem.description ?? ''}'),
            const SizedBox(height: 4,),
          ]
      ),
    );
  }
}
