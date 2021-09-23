import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/model/blood_request.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/edit_input_field.dart';
import 'package:msf/widgets/rounded_button.dart';

class BloodRequestScreen extends StatelessWidget {
  static const PATH = "/blood-request";
   BloodRequestScreen({Key? key}) : super(key: key);

  final bloodGroupController = TextEditingController();
  final phoneNoController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
      final firebaseUser = FirebaseAuth.instance.currentUser!;
      final databaseService = DatabaseService(uid: firebaseUser.uid);

      return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FutureBuilder<BloodRequest>(
                future: databaseService.sendBloodRequestData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    final bloodRequest = snapshot.requireData;
                    return _buildBody(context, bloodRequest, databaseService);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      );
  }

  Widget _buildBody(
      BuildContext context, BloodRequest bloodRequest, DatabaseService databaseService){
    bloodGroupController.text = bloodRequest.bloodGroup ?? '';
    phoneNoController.text = bloodRequest.phoneNo ?? '';
    descriptionController.text = bloodRequest.description ?? '';

    return Column(
      children: [
        SizedBox(height: 12,),
        Center(
          child: Text("Post for Blood Request",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 16,
        ),
        EditInputField(
          hintText: 'Blood Group',
          controller: bloodGroupController,
        ),
        SizedBox(
          height: 12,
        ),
        EditInputField(
          hintText: 'Contact Number',
          controller: phoneNoController,
        ),
        SizedBox(
          height: 12,
        ),
        EditInputField(
          hintText: 'Description',
          controller: descriptionController,
        ),
        SizedBox(
          height: 20,
        ),
        RoundedButton(
            text: 'Save ',
            press: () async {
              final bloodGroup = bloodGroupController.text;
              final phoneNo = phoneNoController.text;
              final description = descriptionController.text;

              final data = {
                'bloodGroup': bloodGroup,
                'phoneNo': phoneNo,
                'description': description,
              };

              await databaseService.updateProfile(data);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
