import 'package:flutter/material.dart';
import 'package:msf/data/model/item/medicine_item.dart';
import 'package:msf/widgets/app_bar.dart';

class MedicineDetails extends StatelessWidget {
  MedicineDetails(this.medicineItem, {Key? key}) : super(key: key);
  MedicineItem medicineItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsfAppBar(title: medicineItem.name ?? ''),
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
