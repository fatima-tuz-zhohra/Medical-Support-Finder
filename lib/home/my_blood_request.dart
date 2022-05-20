import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/blood_request.dart';
import 'package:msf/services/blood_request_service.dart';

class MyBloodRequest extends StatelessWidget {
  const MyBloodRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;

    return Container(
      height: 120,
      child: StreamBuilder<List<BloodRequest>>(
        stream: BloodRequestService().getMyRequests(firebaseUser.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final bloodRequests = snapshot.requireData;
            return _buildList(context, bloodRequests);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, List<BloodRequest> entries) {
    if (entries.isEmpty)
      return Center(child: Text('No blood request posted yet.'));

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        final request = entries[index];
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 332,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30.0,
                backgroundColor: Colors.brown.shade800,
                child: Center(child: Text(request.bloodGroup)),
              ),
              title: Text(request.description,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(request.posted_on),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(label: Text(request.phoneNo)),
                      SizedBox(width: 4),
                      Chip(label: Text(request.status), backgroundColor: Colors.amber),
                    ],
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
}
