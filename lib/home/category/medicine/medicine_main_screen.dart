import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/data/model/list/mock_medicine_list.dart';
import 'package:msf/data/model/item/medicine_item.dart';
import 'package:msf/home/category/medicine/medicine_details.dart';
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
      body:  Column(
        children: [
          SearchView(onTextChange: (String ) { },
          ),

          Expanded(
            child: ListView.builder(
                itemCount: medicineEntries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                          child: Icon(Icons.medical_services),
                      ),
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
        ],
      ),
      );
  }
}
