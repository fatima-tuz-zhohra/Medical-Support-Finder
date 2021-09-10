import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/bloodDoners_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonorsScreen extends StatefulWidget {
  const BloodDonorsScreen({Key? key}) : super(key: key);

  @override
  _BloodDonorsScreenState createState() => _BloodDonorsScreenState();
}

class _BloodDonorsScreenState extends State<BloodDonorsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Donors'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SearchView(
            onTextChange: (String) {},
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: BloodDonorService().getBloodDonor(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: 44,
                      width: 44,
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    final List<BloodDonorsItem> bloodDonors = [];

                    data.docs.forEach((element) {
                      final dbItem = element.data()! as Map<String, dynamic>;
                      final bloodDonor = BloodDonorsItem(
                          dbItem['name'],
                          dbItem['address'],
                          dbItem['bloodGroup'],
                          dbItem['phoneNo']);
                      bloodDonors.add(bloodDonor);
                    });
                    return ListView.builder(
                        itemCount: bloodDonors.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text('${bloodDonors[index].name} (${bloodDonors[index].bloodGroup})'),
                              subtitle: Text('${bloodDonors[index].address}'),
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: 18,
                                    icon: const Icon(Icons.call),
                                    color: theme.colorScheme.secondary,
                                    onPressed: () {
                                      launch(
                                          'tel://${bloodDonors[index].phoneNo}');
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 18,
                                    icon: const Icon(Icons.sms),
                                    color: theme.colorScheme.secondary,
                                    onPressed: () {
                                      launch(
                                          'sms://${bloodDonors[index].phoneNo}');
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
