import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/bloodBank_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodBankScreen extends StatefulWidget {
  const BloodBankScreen({Key? key}) : super(key: key);

  @override
  _BloodBankScreenState createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Bank'),
      ),
      body: Column(
        children: [
          SearchView(onTextChange: (String ) { },
          ),
          
          Expanded(
            child: StreamBuilder<QuerySnapshot<Object?>>(
              stream: BloodBankService().getBloodBank(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  else if (snapshot.hasData) {
                    final data = snapshot.requireData;
                    final List<BloodBankItem> bloodBanks = [];

                    data.docs.forEach((element) {
                      final dbItem = element.data()! as Map<String, dynamic>;
                      final bloodBank = BloodBankItem(
                        dbItem['name'],
                        dbItem['address'],
                        dbItem['phoneNo'],
                        double.parse("${dbItem['latitude']}"),
                        double.parse("${dbItem['longitude']}"),
                      );

                      bloodBanks.add(bloodBank);
                    });
                    return ListView.builder(
                        itemCount: bloodBanks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ListTile(
                              title: Text('${bloodBanks[index].name}'),
                              subtitle: Text('${bloodBanks[index].address}'),
                              trailing: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: 18,
                                    icon: const Icon(Icons.location_on),
                                    color: theme.colorScheme.secondary,
                                    onPressed: () {
                                      navigateTo(bloodBanks[index].latitude,
                                          bloodBanks[index].longitude);
                                    },
                                  ),
                                  IconButton(
                                    iconSize: 18,
                                    icon: const Icon(Icons.call),
                                    color: theme.colorScheme.secondary,
                                    onPressed: () {
                                      launch(('tel://${bloodBanks[index]
                                          .phoneNo}'));
                                    },
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }
                  else {
                    return Container();
                  }
                }
            ),

            /*ListView.builder(
              itemCount: bloodBankEntries.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${bloodBankEntries[index].name}'),
                    subtitle: Text('${bloodBankEntries[index].address}'),
                    trailing:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 18,
                          icon: const Icon(Icons.location_on),
                          color: theme.colorScheme.secondary,
                          onPressed:() {
                            navigateTo(bloodBankEntries[index].latitude, bloodBankEntries[index].longitude);
                          },
                        ),
                        IconButton(
                          iconSize: 18,
                          icon: const Icon(Icons.call),
                          color: theme.colorScheme.secondary,
                          onPressed:() {
                            launch(('tel://${bloodBankEntries[index].phoneNo}'));
                          },
                        )
                      ],
                    ),


                  ),
                );
              },
            ),*/

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
