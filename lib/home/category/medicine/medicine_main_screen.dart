import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/data/mock_medicine_list.dart';
import 'package:msf/data/model/medicine_item.dart';
import 'package:msf/home/category/medicine/medicine_details.dart';

class MedicineMainScreen extends StatefulWidget {
  const MedicineMainScreen({Key? key}) : super(key: key);

  @override
  _MedicineMainScreenState createState() => _MedicineMainScreenState();
}

class _MedicineMainScreenState extends State<MedicineMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30.0),
          bottomRight: Radius.circular(30.0),
        )),
        centerTitle: true,
        title: Text('Medicine'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: medicineEntries.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(),
                title: Text('${medicineEntries[index].name}'),
                subtitle: Text('${medicineEntries[index].generic}'),
                trailing: Text('${medicineEntries[index].price}'),
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return MedicineDetails(medicineEntries[index]);
                      }));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
