import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/data/model/profile.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/edit_input_field.dart';
import 'package:msf/widgets/msf_base_page_layout.dart';
import 'package:msf/widgets/rounded_button.dart';

class EditProfileScreen extends StatelessWidget {
  static const PATH = "/edit-profile";

  EditProfileScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    final databaseService = DatabaseService(uid: firebaseUser.uid);

    return Scaffold(
      appBar: MsfAppBar(title: 'Edit Profile'),
      body: MsfBasePageLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: FutureBuilder<Profile>(
                  future: databaseService.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      final profile = snapshot.requireData;
                      return _buildBody(context, profile, databaseService);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, Profile profile, DatabaseService databaseService) {
    nameController.text = profile.name;
    addressController.text = profile.address ?? '';
    phoneNoController.text = profile.phoneNo;

    return Column(
      children: [
        EditInputField(
          hintText: 'name',
          controller: nameController,
        ),
        SizedBox(
          height: 12,
        ),
        EditInputField(
          hintText: 'address',
          controller: addressController,
        ),
        SizedBox(
          height: 12,
        ),
        EditInputField(
          hintText: 'phoneNo',
          controller: phoneNoController,
        ),
        SizedBox(
          height: 20,
        ),
        RoundedButton(
            text: 'Save ',
            press: () async {
              final name = nameController.text;
              final address = addressController.text;
              final phoneNo = phoneNoController.text;

              final data = {
                'name': name,
                'address': address,
                'phoneNo': phoneNo,
              };

              await databaseService.updateProfile(data);
              Navigator.pop(context);
            }),
      ],
    );
  }
}
