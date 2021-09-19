import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalHospitalListView extends StatelessWidget {
  HorizontalHospitalListView({Key? key}) : super(key: key);

  final List<String> hospitals = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
      Container(
        height: 150,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: hospitals.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Container(
                width: 150,
                child: ListTile(
                  title: Text('name'),
                  subtitle: Text('address'),
                  trailing: IconButton(
                    iconSize: 18,
                    icon: const Icon(Icons.location_on),
                    color: theme.colorScheme.secondary,
                    onPressed: () {
                    },
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context,
              int index) => const Divider(),
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
