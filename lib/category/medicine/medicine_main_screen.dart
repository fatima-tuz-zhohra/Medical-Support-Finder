import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/medicine_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/search_view.dart';

import 'medicine_details.dart';

class MedicineMainScreen extends StatefulWidget {
  const MedicineMainScreen({Key? key}) : super(key: key);

  @override
  _MedicineMainScreenState createState() => _MedicineMainScreenState();
}

class _MedicineMainScreenState extends State<MedicineMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsfAppBar(title: 'Medicine'),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot<Object?>>(
          stream: MedicineService().getMedicines(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                height: 44,
                width: 44,
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.requireData;
              final List<MedicineItem> medicines = [];

              data.docs.forEach((element) {
                final dbItem = element.data()! as Map<String, dynamic>;
                final medicine = MedicineItem(
                    dbItem['name'],
                    dbItem['generic'],
                    dbItem['companyName'],
                    double.parse("${dbItem['price']}"),
                    dbItem['description']);
                medicines.add(medicine);
              });
              return MedicineListContent(medicines: medicines);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class MedicineListContent extends StatefulWidget {
  const MedicineListContent({Key? key, required this.medicines})
      : super(key: key);
  final List<MedicineItem> medicines;

  @override
  _MedicineListContentState createState() => _MedicineListContentState();
}

class _MedicineListContentState extends State<MedicineListContent> {
  List<MedicineItem> medicines = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      medicines = widget.medicines;
    }
    return Column(
      children: [
        SearchView(onTextChange: (text) {
          print(text);
          print('Current list size ${medicines.length}');

          List<MedicineItem> filtered = [];
          widget.medicines.forEach((element) {
            if (element.name != null &&
                element.name!.toLowerCase().startsWith(text.toLowerCase())) {
              filtered.add(element);
            }
          });

          print('Matched: ${filtered.length} items');

          setState(() {
            searchKey = text;
            medicines = filtered;
          });
        }),
        Expanded(
          child: ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/icons/medicine_icon3.png'),
                  ),
                  title: Text('${medicines[index].name}'),
                  subtitle: Text('${medicines[index].generic}'),
                  trailing: Text(' ৳  ${medicines[index].price}'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MedicineDetails(medicines[index]);
                    }));
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
