import 'package:flutter/material.dart';
import 'package:msf/data/model/item/medicine_item.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/back_button.dart';

class MedicineDetails extends StatelessWidget {
  MedicineDetails(this.medicineItem, {Key? key}) : super(key: key);
  MedicineItem medicineItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/generic_medicine_details_image.PNG', fit: BoxFit.cover),
              SafeArea(child: MsfBackButton()),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${medicineItem.name ?? ''}',
                        style: Theme.of(context).textTheme.headline5),
                    Text('${medicineItem.companyName ?? ' '}',
                        style: Theme.of(context).textTheme.caption),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Chip(label: Text('${medicineItem.generic ?? ''}')),
                        Text('৳${medicineItem.price}',
                            style: Theme.of(context).textTheme.headline6),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'About the product',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('${medicineItem.description ?? ''}'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
