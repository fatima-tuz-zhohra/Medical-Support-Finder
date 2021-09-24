import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msf/data/model/blood_request.dart';

class BloodRequestService {
  final CollectionReference bloodRequestCollection =
      FirebaseFirestore.instance.collection('blood_request');

  Future<void> newRequest(BloodRequest newRequest) async {
    final doc = bloodRequestCollection.doc();
    newRequest..docId = doc.id;
    final data = newRequest.toMap();
    data['posted_on'] = FieldValue.serverTimestamp();
    await doc.set(data);
    return;
  }

  Stream<List<BloodRequest>> getMyRequests(String uid) {
    final stream =
        bloodRequestCollection.where('uid', isEqualTo: uid).snapshots();

    return stream.map((updatedCollection) {
      final List<BloodRequest> bloodRequests = [];
      updatedCollection.docs.forEach((element) {
        final data = element.data() as Map<String, dynamic>;
        final request = BloodRequest.fromMap(data);
        bloodRequests.add(request);
      });
      return bloodRequests;
    });
  }
}
