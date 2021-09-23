import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/item/hospital_item.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HospitalMainScreen extends StatefulWidget {
  static const PATH = "/hospitals";

  const HospitalMainScreen({Key? key}) : super(key: key);

  @override
  _HospitalMainScreenState createState() => _HospitalMainScreenState();
}

class _HospitalMainScreenState extends State<HospitalMainScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: MsfAppBar(title: 'Hospital'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<List<HospitalItem>>(
            stream: HospitalService().getHospital(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                final hospitals = snapshot.requireData;
                return HospitalListContent(hospitals: hospitals);
              } else {
                return Container();
              }
            }),
      ),
    );
  }
}

class HospitalListContent extends StatefulWidget {
  const HospitalListContent({Key? key, required this.hospitals})
      : super(key: key);
  final List<HospitalItem> hospitals;

  @override
  _HospitalListContentState createState() => _HospitalListContentState();
}

class _HospitalListContentState extends State<HospitalListContent> {
  List<HospitalItem> hospitals = [];
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (searchKey.isEmpty) {
      hospitals = widget.hospitals;
    }
    return Column(
      children: [
        SearchView(onTextChange: (text) {
          print(text);
          print('Current list size ${hospitals.length}');

          List<HospitalItem> filtered = [];
          widget.hospitals.forEach((element) {
            if (element.name != null &&
                element.name!.toLowerCase().startsWith(text.toLowerCase())) {
              filtered.add(element);
            }
          });

          print('Matched: ${filtered.length} items');

          setState(() {
            searchKey = text;
            hospitals = filtered;
          });
        }),
        Expanded(
          child: ListView.builder(
            itemCount: hospitals.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text('${hospitals[index].name}'),
                  subtitle: Text('${hospitals[index].address}'),
                  trailing: IconButton(
                    iconSize: 18,
                    icon: const Icon(Icons.location_on),
                    color: theme.colorScheme.secondary,
                    onPressed: () {
                      navigateTo(hospitals[index].latitude,
                          hospitals[index].longitude);
                    },
                  ),
                ),
              );
            },
          ),
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
