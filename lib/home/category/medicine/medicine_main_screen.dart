import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/medicine_item.dart';
import 'package:msf/home/category/medicine/medicine_details.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';

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
        centerTitle: true,
        title: Text('Medicine'),
      ),
      body: Column(
        children: [
          SearchView(
            onTextChange: (String) {},
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: MedicineService().getMedicines(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
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

                  return ListView.builder(
                    itemCount: medicines.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.medical_services),
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
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
