import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalHospitalListView extends StatelessWidget {
  HorizontalHospitalListView({Key? key}) : super(key: key);

  final List<String> hospitals = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displaySize = MediaQuery.of(context).size;

    return Container(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hospitals.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Container(
              width: displaySize.width * .8,
              child: ListTile(
                title: Text('name'),
                subtitle: Text('address'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: 4),
                    Icon(
                      Icons.call,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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
