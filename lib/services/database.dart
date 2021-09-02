import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('Users');

  Future updateUserData(String name, String phoneNo, String email, String image) async{
    return await usersCollection.doc(uid).set({
      'name' : name,
      'phoneNo' : phoneNo,
      'email' : email,
      'image' : image,
    }
    );
  }
}