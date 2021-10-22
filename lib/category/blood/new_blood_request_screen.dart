import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/data/model/blood_request.dart';
import 'package:msf/services/blood_request_service.dart';
import 'package:msf/services/database.dart';
import 'package:msf/utils/utils.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/edit_input_field.dart';
import 'package:msf/widgets/msf_base_page_layout.dart';
import 'package:msf/widgets/rounded_button.dart';

class BloodRequestScreen extends StatelessWidget {
  static const PATH = "/new-blood-request";

  BloodRequestScreen({Key? key}) : super(key: key);

  final bloodGroupController = TextEditingController();
  final phoneNoController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MsfAppBar(),
      body: MsfBasePageLayout(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: _buildBody(context),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    final userDatabaseService = DatabaseService(uid: firebaseUser.uid);
    final bloodRequestService = BloodRequestService();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 16),
          EditInputField(
            hintText: 'Blood Group',
            controller: bloodGroupController,
            leading: Icon(Icons.bloodtype),
            validator: (value) {
              final isValid = value != null
                  ? RegExp(AppConstants.bloodGroupValidation).hasMatch(value)
                  : false;

              if (isValid)
                return null;
              else
                return 'Please enter valid blood group';
            },
          ),
          SizedBox(height: 12),
          EditInputField(
            hintText: 'Contact Number',
            controller: phoneNoController,
            leading: Icon(Icons.phone),
            validator: (value) {
              final isValid = value != null
                  ? RegExp(AppConstants.phoneNumberValidation).hasMatch(value)
                  : false;

              if (isValid)
                return null;
              else
                return 'Please enter valid phone number';
            },
          ),
          SizedBox(height: 12),
          EditInputField(
            hintText: 'Description',
            controller: descriptionController,
            leading: Icon(Icons.document_scanner),
            maxline: 5,
            validator: (value) {
              if (value == null || value.length < 50)
                return 'Please enter minimum 50 letter';
              else
                return null;
            },
          ),
          SizedBox(height: 20),
          RoundedButton(
              text: 'Post Blood Request ',
              press: () async {
                if (_formKey.currentState?.validate() == true) {
                  final user = await userDatabaseService.getUserData();
                  final bloodRequest = BloodRequest(
                    uid: firebaseUser.uid,
                    name: user.name,
                    picture: user.image,
                    phoneNo: phoneNoController.text,
                    bloodGroup: bloodGroupController.text,
                    description: descriptionController.text,
                  );
                  await bloodRequestService.newRequest(bloodRequest);
                  showSnackbar(context, 'Blood Request submitted');
                  Navigator.pop(context);
                } else {
                  showSnackbar(context, 'Invalid inputs');
                }
              }),
        ],
      ),
    );
  }
}
