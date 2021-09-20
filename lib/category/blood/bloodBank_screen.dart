import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/bloodBank_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodBankScreen extends StatefulWidget {
  static const PATH = "/blood-banks";
  const BloodBankScreen({Key? key}) : super(key: key);

  @override
  _BloodBankScreenState createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blood Bank'),
      ),
      body: StreamBuilder<List<BloodBankItem>>(
          stream: BloodBankService().getBloodBank(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final bloodBanks = snapshot.requireData;
              return BloodBankListContent(bloodBanks: bloodBanks);
            } else {
              return Container();
            }
          }),
    );
  }
}

class BloodBankListContent extends StatefulWidget {
  const BloodBankListContent({Key? key, required this.bloodBanks})
      : super(key: key);
  final List<BloodBankItem> bloodBanks;

  @override
  _BloodBankListContentState createState() => _BloodBankListContentState();
}

class _BloodBankListContentState extends State<BloodBankListContent> {
  List<BloodBankItem> bloodBanks = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      bloodBanks = widget.bloodBanks;
    }

    return Column(
      children: [
        SearchView(onTextChange: (text) {
          print(text);
          print('Current list size ${bloodBanks.length}');

          List<BloodBankItem> filtered = [];
          widget.bloodBanks.forEach((element) {
            if (element.name != null &&
                element.name!.toLowerCase().startsWith(text.toLowerCase())) {
              filtered.add(element);
            }
          });

          print('Matched: ${filtered.length} items');

          setState(() {
            searchKey = text;
            bloodBanks = filtered;
          });
        }),
        Expanded(
          child: ListView.builder(
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
                            launch(('tel://${bloodBanks[index].phoneNo}'));
                          },
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
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
