import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:location/location.dart';
import 'package:msf/data/model/item/hospital_item.dart';
import 'package:msf/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalHospitalListView extends StatelessWidget {
  HorizontalHospitalListView({Key? key}) : super(key: key);

  final List<String> hospitals = <String>['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final currentLocation = snapshot.requireData;
            print('Current Location $currentLocation');

            final dbService = HospitalService();
            return StreamBuilder<List<HospitalItem>>(
                stream: dbService.getHospital(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final hospitals =
                        _filterNearby(snapshot.requireData, currentLocation);
                    return _buildListView(context, hospitals);
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  List<HospitalItem> _filterNearby(
      List<HospitalItem> allHospitals, Position currentLocation) {
    final List<HospitalItem> nearby = [];

    int i = 0;
    for (i = 0; i < allHospitals.length; i++) {
      final hospital = allHospitals[i];
      final distance = Geolocator.distanceBetween(currentLocation.latitude,
          currentLocation.longitude, hospital.latitude, hospital.longitude);
      if(distance <= 5000){
        hospital.distance = distance/1000;
        nearby.add(hospital);
      }
    }

    return nearby;
  }

  void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("http://maps.google.com/maps?daddr=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

  Widget _buildListView(BuildContext context, List<HospitalItem> hospitals) {
    if(hospitals.isEmpty) return Center(child: Text('No nearby hospital found!'));

    final theme = Theme.of(context);
    final displaySize = MediaQuery.of(context).size;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: hospitals.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            width: displaySize.width * .8,
            child: ListTile(
              title: Text('${hospitals[index].name}'),
              subtitle: Text('${hospitals[index].address}\n\n${hospitals[index].distance?.toStringAsFixed(2)} KM.'),
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
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
