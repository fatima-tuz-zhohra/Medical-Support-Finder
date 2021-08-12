import 'package:flutter/material.dart';
import 'package:msf/data/model/list/mock_hospital_list.dart';
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
      body: SafeArea(
        child: ListView.builder(
          itemCount: hospitalEntries.length,
            itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('${hospitalEntries[index].name}'),
                subtitle: Text('${hospitalEntries[index].location}'),
                trailing:  IconButton(
                  iconSize: 18,
                  icon: const Icon(Icons.location_on),
                  color: theme.colorScheme.secondary,
                  onPressed:() {
                    navigateTo(hospitalEntries[index].latitude, hospitalEntries[index].longitude);
                  },
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
