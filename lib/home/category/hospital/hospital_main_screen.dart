import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/hospital_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalMainScreen extends StatefulWidget {
  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  _HospitalMainScreenState createState() => _HospitalMainScreenState();
}

class _HospitalMainScreenState extends State<HospitalMainScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hospital'),
      ),

      body: Column(
        children: [
          SearchView(
            onTextChange: (String) {},
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: HospitalService().getHospital(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  else if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    final List<HospitalItem> hospitals = [];

                    data.docs.forEach((element) {
                      final dbItem = element.data()! as Map<String, dynamic>;
                      final hospital = HospitalItem(
                        dbItem['name'],
                        dbItem['address'],
                        double.parse("${dbItem['latitude']}"),
                        double.parse("${dbItem['longitude']}"),
                      );
                      hospitals.add(hospital);
                    });

                    return ListView.builder(
                        itemCount: hospitals.length,
                        itemBuilder: (BuildContext context, int index){
                      return Card(
                        child: ListTile(
                          title: Text('${hospitals[index].name}'),
                          subtitle: Text('${hospitals[index].address}'),
                          trailing: IconButton(
                            iconSize: 18,
                            icon: const Icon(Icons.location_on),
                            color: theme.colorScheme.secondary,
                            onPressed: () {
                              navigateTo(hospitals[index].latitude, hospitals[index].longitude);
                            },
                          ),
                        ),

                      );
                    },
                    );
                  }
                else {
                    return Container();
                  }
            }
            ),
          ),

        ],
      ),
    );
  }
  void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("http://maps.google.com/maps?daddr=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
