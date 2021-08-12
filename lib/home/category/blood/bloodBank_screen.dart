import 'package:flutter/material.dart';
import 'package:msf/data/model/list/mock_bloodBank_list.dart';
import 'package:url_launcher/url_launcher.dart';
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
      body: SafeArea(
        child:
          ListView.builder(
            itemCount: BloodBankEntries.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('${BloodBankEntries[index].name}'),
                  subtitle: Text('${BloodBankEntries[index].address}'),
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
                          navigateTo(BloodBankEntries[index].latitude, BloodBankEntries[index].longitude);
                        },
                      ),
                      IconButton(
                        iconSize: 18,
                        icon: const Icon(Icons.call),
                        color: theme.colorScheme.secondary,
                        onPressed:() {
                          launch(('tel://${BloodBankEntries[index].phoneNo}'));
                        },
                      )
                    ],
                  ),


                ),
              );
            },
          )
      ),
      );
  }
  void navigateTo(double lat, double lng) async {
    //var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    var uri = Uri.parse("http://maps.google.com/maps?daddr=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
