import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:msf/data/model/item/bloodBank_item.dart';
import 'package:msf/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class TopBloodBanksListView extends StatelessWidget {
  TopBloodBanksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: 150, child: _buildMainContent());
  }

  Widget _buildMainContent() {
    final dbService = BloodBankService();
    return StreamBuilder<List<BloodBankItem>>(
        stream: dbService.getBloodBank(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final bloodBanks = snapshot.requireData.sublist(0, max(0, 5));
            return _buildListView(context, bloodBanks);
          } else {
            return Container();
          }
        });
  }

  Widget _buildListView(BuildContext context, List<BloodBankItem> bloodBanks) {
    if (bloodBanks.isEmpty) return Center(child: Text('No blood banks found!'));

    final theme = Theme.of(context);
    final displaySize = MediaQuery.of(context).size;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: bloodBanks.length,
      itemBuilder: (BuildContext context, int index) {
        Color color = Colors.white;
        final textTheme = Theme.of(context).primaryTextTheme;
        double rating = 5.0 - (index * .20);

        if (index % 3 == 0) {
          color = Colors.indigo.shade500;
        } else if (index % 3 == 1) {
          color = Colors.pink.shade400;
        } else if (index % 3 == 2) {
          color = Colors.orange.shade900;
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
                '${bloodBanks[index].name}',
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
                    '${bloodBanks[index].address}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.subtitle1?.copyWith(fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      RatingBar(
                          ignoreGestures: true,
                          itemSize: 20,
                          initialRating: rating,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            full: Icon(Icons.star, color: Colors.amber),
                            half: Icon(Icons.star_half, color: Colors.amber),
                            empty: Icon(Icons.star_border, color: Colors.amber),
                          ),
                          onRatingUpdate: (rating) {
                            print('Rating: $rating');
                          }),
                      SizedBox(width: 4),
                      Text(
                        '$rating',
                        style: textTheme.bodyText2
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
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
                      navigateTo(bloodBanks[index].latitude,
                          bloodBanks[index].longitude);
                    },
                  ),
                  SizedBox(height: 4),
                  InkWell(
                    child: Icon(
                      Icons.call,
                      color: theme.colorScheme.onPrimary,
                    ),
                    onTap: () {
                      launch(('tel://${bloodBanks[index].phoneNo}'));
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
}
