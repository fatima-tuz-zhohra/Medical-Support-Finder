import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:msf/data/model/item/bloodBank_item.dart';
import 'package:msf/data/model/item/hospital_item.dart';
import 'package:msf/data/model/profile.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> updateUserData(String name, String phoneNo, String email,
      String role, String image) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'role': role,
      'image': image,
    });
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    return await usersCollection.doc(uid).update(data);
  }

  Future<void> becomeBloodDonor(Profile profile) async {
    final data = {'isBloodDonor': true};
    final bloodDonorService = BloodDonorService();
    bloodDonorService.addDonor(
      uid: uid,
      name: profile.name,
      bloodGroup: profile.bloodGroup ?? '',
      phoneNo: profile.phoneNo,
      address: profile.address,
    );
    return await updateProfile(data);
  }

  Future<void> removeBloodDonor() async {
    final data = {'isBloodDonor': false};
    final bloodDonorService = BloodDonorService();
    bloodDonorService.deleteDonor(uid: uid);
    return await updateProfile(data);
  }

  Future<bool> isExistingUser() async {
    final data = await usersCollection.doc(uid).get();
    return data.exists;
  }

  Future<Profile> getUserData() async {
    final doc = await usersCollection.doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;
    final profile = Profile(
      data['name'],
      data['email'],
      data['phoneNo'],
      data['role'],
      data['image'],
      isBloodDonor: data['isBloodDonor'] ?? false,
      bloodGroup: data['bloodGroup'],
      address: data['address'],
    );
    return profile;
  }

  Stream<Profile> getUserDataStream() {
    final stream = usersCollection.doc(uid).snapshots();

    return stream.map((updatedDoc) {
      final data = updatedDoc.data() as Map<String, dynamic>;
      final profile = Profile(
        data['name'],
        data['email'],
        data['phoneNo'],
        data['role'],
        data['image'],
        isBloodDonor: data['isBloodDonor'] ?? false,
        bloodGroup: data['bloodGroup'],
        address: data['address'],
      );
      return profile;
    });
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

  Stream<List<HospitalItem>> getHospital() {
    final stream = hospitalCollection.snapshots();
    return stream.map((updatedCollection) {
      final List<HospitalItem> hospitals = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final hospital = HospitalItem(
          dbItem['name'],
          dbItem['address'],
          dbItem['latitude'],
          dbItem['longitude'],
          dbItem['type'],
        );
        hospitals.add(hospital);
      });
      return hospitals;
    });
  }
}

class BloodBankService {
  BloodBankService();

  final CollectionReference bloodBankCollection =
      FirebaseFirestore.instance.collection('Blood Bank');

  Stream<List<BloodBankItem>> getBloodBank() {
    final stream = bloodBankCollection.snapshots();
    return stream.map((updatedCollection) {
      final List<BloodBankItem> bloodBanks = [];
      updatedCollection.docs.forEach((element) {
        final dbItem = element.data()! as Map<String, dynamic>;
        final bloodBank = BloodBankItem(
          dbItem['name'],
          dbItem['address'],
          dbItem['phoneNo'],
          dbItem['latitude'],
          dbItem['longitude'],
        );
        bloodBanks.add(bloodBank);
      });
      return bloodBanks;
    });
  }
}

class BloodDonorService {
  BloodDonorService();

  final CollectionReference bloodDonorCollection =
      FirebaseFirestore.instance.collection('Blood_Donors');

  Future<void> addDonor(
      {required String uid,
      required String name,
      required String bloodGroup,
      String? phoneNo,
      String? address}) async {
    final data = {
      'uid': uid,
      'name': name,
      'bloodGroup': bloodGroup,
      'address': address,
      'phoneNo': phoneNo,
    };
    return await bloodDonorCollection.doc(uid).set(data);
  }

  Future<void> deleteDonor({required String uid}) async {
    return await bloodDonorCollection.doc(uid).delete();
  }

  Stream<QuerySnapshot<Object?>> getBloodDonor() {
    return bloodDonorCollection.snapshots();
  }
}

class OxygenService {
  OxygenService();

  final CollectionReference oxygenCollection =
  FirebaseFirestore.instance.collection('Oxygen_Supplier');

  Stream<QuerySnapshot<Object?>> getOxygen() {
    return oxygenCollection.snapshots();
  }
}
