import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/category/blood/blood_request_screen.dart';
import 'package:msf/data/model/item/bloodDoners_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonorsScreen extends StatefulWidget {
  static const PATH = "/blood-donors";
  const BloodDonorsScreen({Key? key}) : super(key: key);

  @override
  _BloodDonorsScreenState createState() => _BloodDonorsScreenState();
}

class _BloodDonorsScreenState extends State<BloodDonorsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
                return BloodRequestScreen();
              }));
        },
        child: Icon(Icons.post_add_rounded),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Donors'),
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
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
                final bloodDonor = BloodDonorsItem(dbItem['name'],
                    dbItem['address'], dbItem['bloodGroup'], dbItem['phoneNo']);
                bloodDonors.add(bloodDonor);
              });
              return BloodDonorListContent(bloodDonors: bloodDonors);
            } else {
              return Container();
            }
          }),
    );
  }
}

class BloodDonorListContent extends StatefulWidget {
  const BloodDonorListContent({Key? key, required this.bloodDonors})
      : super(key: key);
  final List<BloodDonorsItem> bloodDonors;

  @override
  _BloodDonorListContentState createState() => _BloodDonorListContentState();
}

class _BloodDonorListContentState extends State<BloodDonorListContent> {
  List<BloodDonorsItem> bloodDonors = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      bloodDonors = widget.bloodDonors;
    }
    return Column(
      children: [
        SearchView(onTextChange: (text) {
          print(text);
          print('Current list size ${bloodDonors.length}');

          List<BloodDonorsItem> filtered = [];
          widget.bloodDonors.forEach((element) {
            if (element.name != null &&
                element.name!.toLowerCase().startsWith(text.toLowerCase())) {
              filtered.add(element);
            }
          });

          print('Matched: ${filtered.length} items');

          setState(() {
            searchKey = text;
            bloodDonors = filtered;
          });
        }),
        Expanded(
          child: ListView.builder(
              itemCount: bloodDonors.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(
                        '${bloodDonors[index].name} (${bloodDonors[index].bloodGroup})'),
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
                            launch('tel://${bloodDonors[index].phoneNo}');
                          },
                        ),
                        IconButton(
                          iconSize: 18,
                          icon: const Icon(Icons.sms),
                          color: theme.colorScheme.secondary,
                          onPressed: () {
                            launch('sms://${bloodDonors[index].phoneNo}');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
