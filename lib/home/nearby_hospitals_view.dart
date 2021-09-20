import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:msf/data/model/item/hospital_item.dart';
import 'package:msf/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class HorizontalHospitalListView extends StatelessWidget {
  HorizontalHospitalListView({Key? key}) : super(key: key);

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
            final position = snapshot.requireData;
            return _buildMainContent(position);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildMainContent(Position position) {
    final currentLocation = position;
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
  }

  List<HospitalItem> _filterNearby(
      List<HospitalItem> allHospitals, Position currentLocation) {
    final List<HospitalItem> nearby = [];

    int i = 0;
    for (i = 0; i < allHospitals.length; i++) {
      final hospital = allHospitals[i];
      final distance = Geolocator.distanceBetween(currentLocation.latitude,
          currentLocation.longitude, hospital.latitude, hospital.longitude);
      if (distance <= 5000) {
        hospital.distance = distance / 1000;
        nearby.add(hospital);
      }
    }
    nearby.sort((i1, i2) => i1.distance?.compareTo(i2.distance ?? 0) ?? 0);
    return nearby;
  }

  Widget _buildListView(BuildContext context, List<HospitalItem> hospitals) {
    if (hospitals.isEmpty)
      return Center(child: Text('No nearby hospital found!'));

    final theme = Theme.of(context);
    final displaySize = MediaQuery.of(context).size;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: hospitals.length,
      itemBuilder: (BuildContext context, int index) {
        Color color = Colors.white;
        final textTheme = Theme.of(context).primaryTextTheme;

        if (index % 3 == 0) {
          color = Colors.teal.shade500;
        } else if (index % 3 == 1) {
          color = Colors.brown.shade400;
        } else if (index % 3 == 2) {
          color = Colors.blueGrey.shade500;
        }

        return Card(
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            width: displaySize.width * .8,
            child: ListTile(
              isThreeLine: true,
              title: Text(
                '${hospitals[index].name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.subtitle1
                    ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    '${hospitals[index].address}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle1?.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Chip(
                        label: Text('${hospitals[index].type}'),
                        labelStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      SizedBox(width: 4),
                      Chip(
                        label: Text(
                            '${hospitals[index].distance?.toStringAsFixed(2)} Km'),
                        labelStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.location_on,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onTap: () {
                      navigateTo(hospitals[index].latitude,
                          hospitals[index].longitude);
                    },
                  ),
                  SizedBox(height: 4),
                  InkWell(
                    child: Icon(
                      Icons.call,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onTap: () {
                      launch(('tel://${hospitals[index].phoneNo}'));
                    },
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

  void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("http://maps.google.com/maps?daddr=$lat,$lng");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
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
