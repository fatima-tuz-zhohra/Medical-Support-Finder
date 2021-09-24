import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/utils/utils.dart';

class BloodRequest {
  String docId = '';
  String uid;
  String name;
  String picture;

  String phoneNo;
  String bloodGroup;
  String description;
  String status;
  String posted_on = '';

  BloodRequest({
    required this.uid,
    required this.name,
    required this.picture,
    required this.phoneNo,
    required this.bloodGroup,
    this.status = BloodConstants.open,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'docId': this.docId,
      'uid': this.uid,
      'name': this.name,
      'picture': this.picture,
      'phoneNo': this.phoneNo,
      'bloodGroup': this.bloodGroup,
      'description': this.description,
      'status': this.status,
      'posted_on': this.posted_on,
    };
  }

  factory BloodRequest.fromMap(Map<String, dynamic> map) {
    final request = BloodRequest(
      uid: map['uid'] as String,
      name: map['name'] as String,
      picture: map['picture'] as String,
      phoneNo: map['phoneNo'] as String,
      bloodGroup: map['bloodGroup'] as String,
      status: map['status'] as String,
      description: map['description'] as String,
    );
    request.docId = map['docId'] as String;
    final timeStamp = map['posted_on'] as Timestamp;
    request.posted_on = formatDateTime('dd MMM, yyyy', timeStamp.toDate());

    return request;
  }
}
