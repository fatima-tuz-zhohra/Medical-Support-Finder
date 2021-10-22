import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/blood_request.dart';
import 'package:msf/services/blood_request_service.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/msf_base_page_layout.dart';
import 'package:msf/widgets/msf_list_item.dart';
import 'package:url_launcher/url_launcher.dart';

import 'new_blood_request_screen.dart';

class AllBloodRequestScreen extends StatelessWidget {
  static const PATH = "/all-blood-request";

  const AllBloodRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('New Request'),
        onPressed: () {
          Navigator.pushNamed(context, BloodRequestScreen.PATH);
        },
      ),
      appBar: MsfAppBar(
        title: 'All Blood Requests',
      ),
      body: MsfBasePageLayout(
        child: StreamBuilder<List<BloodRequest>>(
          stream: BloodRequestService().getAllRequests(firebaseUser.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              final bloodRequests = snapshot.requireData;
              return _buildList(context, bloodRequests);
            } else {
              return Container(child: Center(child: Text('No open blood request found')));
            }
          },
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<BloodRequest> entries) {
    if (entries.isEmpty)
      return Center(child: Text('No open blood request found'));
    final theme = Theme.of(context);
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final request = entries[index];
        return MsfListItem(
          child: ListTile(
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(request.picture),
                ),
                SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request.name),
                    Text(request.posted_on, style: theme.textTheme.caption),
                  ],
                ),
                Spacer(),
                if (firebaseUser.uid == request.uid)
                  IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.more_horiz),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12),
                Text(request.description),
                SizedBox(height: 8),
                Chip(
                    label: Text('      ${request.bloodGroup}      '),
                    backgroundColor: Colors.amber),
                SizedBox(height: 8),
                Divider(height: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      //  iconSize: 18,
                      icon: const Icon(Icons.call),
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        launch('tel://${request.phoneNo}');
                      },
                    ),
                    SizedBox(width: 4),
                    IconButton(
                      //  iconSize: 18,
                      icon: const Icon(Icons.sms),
                      color: theme.colorScheme.secondary,
                      onPressed: () {
                        launch('sms://${request.phoneNo}');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
