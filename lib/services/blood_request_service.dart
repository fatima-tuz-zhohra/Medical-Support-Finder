import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msf/data/model/blood_request.dart';

class BloodRequestService {
  final CollectionReference bloodRequestCollection =
      FirebaseFirestore.instance.collection('blood_request');

  Future<void> newRequest(BloodRequest newRequest) async {
    final doc = bloodRequestCollection.doc();
    newRequest..docId = doc.id;
    final data = newRequest.toMap();
    await doc.set(data);
    return;
  }
}
