import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msf/home/home_main/settings/profile.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(
      String name, String phoneNo, String email, String image) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'image': image,
    });
  }

  Future<Profile> getUserData() async {
    final doc = await usersCollection.doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    final profile =
        Profile(data['name'], data['email'], data['phoneNo'], data['image']);
    return profile;
  }
}

class MedicineService {
  MedicineService();

  final CollectionReference medicineCollection =
      FirebaseFirestore.instance.collection('Medicine');

  Stream<QuerySnapshot<Object?>> getMedicines() {
    return medicineCollection.snapshots();
  }
}

class HospitalService {
  HospitalService();

  final CollectionReference hospitalCollection =
  FirebaseFirestore.instance.collection('Hospitals');

  Stream<QuerySnapshot<Object?>> getHospital() {
    return hospitalCollection.snapshots();
  }
}
