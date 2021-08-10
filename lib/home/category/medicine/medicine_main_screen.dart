import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/data/mock_medicine_list.dart';
import 'package:msf/data/model/medicine_item.dart';

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
          topLeft: Radius.circular(50.0),
          bottomRight: Radius.circular(50.0),
        )),
        centerTitle: true,
        title: Text('Medicine'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(),
                title: Text('${entries[index].name}'),
                subtitle: Text('${entries[index].generic}'),
                trailing: Text('${entries[index].price}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
