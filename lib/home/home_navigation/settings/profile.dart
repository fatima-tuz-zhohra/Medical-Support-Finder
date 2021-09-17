import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/data/model/profile.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/rounded_button.dart';
import 'package:msf/widgets/single_input_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<Profile>(
            future: DatabaseService(uid: firebaseUser?.uid ?? '').getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                final profile = snapshot.requireData;
                return _createProfileView(context, profile);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _createProfileView(BuildContext context, Profile profile) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ]),
          ),
          child: Row(
            children: [
              Container(
                height: 110,
                width: 110,
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(profile.image),
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle),
              ),
              SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_createName(profile),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(profile.email,
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(height: 4),
                  if (profile.phoneNo.isNotEmpty)
                    Text(profile.phoneNo,
                        style: Theme.of(context).textTheme.subtitle2),
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Address'),
                subtitle: Text(profile.address ?? ''),
              ),
            ),
            _createBloodDonorCard(context, profile),
          ],
        ),
        SizedBox(height: 40),
        RoundedButton(text: 'LogOut', press: _signOut),
      ],
    );
  }

  String _createName(Profile profile) {
    StringBuffer name = StringBuffer(profile.name);

    if (profile.bloodGroup != null && profile.bloodGroup!.isNotEmpty) {
      name.write(" (${profile.bloodGroup})");
    }

    return name.toString();
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LogInPage();
    }));
  }

  Widget _createBloodDonorCard(BuildContext context, Profile profile) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.call),
        trailing: Switch(
            value: profile.isBloodDonor,
            onChanged: (newValue) async {
              final firebaseUser = FirebaseAuth.instance.currentUser;
              final service = DatabaseService(uid: firebaseUser?.uid ?? '');
              if (newValue == true) {
                await becomeBloodDonor(profile);
              } else {
                //user doesn't wants to stay a blood donor
                await service.removeBloodDonor();
                setState(() {});
              }
            }),
        title: Text('Donate Blood'),
        subtitle: Text(profile.isBloodDonor ? 'Yes' : 'No'),
      ),
    );
  }

  Future<void> becomeBloodDonor(Profile profile) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final service = DatabaseService(uid: firebaseUser?.uid ?? '');
    if (profile.bloodGroup == null || profile.bloodGroup!.isEmpty) {
      // User doesn't have bloodGroup in his/her profile. Let's ask for blood group
      final String? bloodGroup = await showDialog(
          context: context,
          builder: (context) => SingleInputDialog(
              hint: 'Enter Blood Group',
              validation: AppConstants.bloodGroupValidation));
      if (bloodGroup != null && bloodGroup.isNotEmpty) {
        //Got the blood group.... Yeeeee!
        service.updateProfile({'bloodGroup': bloodGroup});
        profile.bloodGroup = bloodGroup;
        await service.becomeBloodDonor(profile);
        setState(() {});
      } else {
        // User didn't provide blood group. Let's do nothing!!!
      }
    } else {
      // user has blood group.
      await service.becomeBloodDonor(profile);
      setState(() {});
    }
  }
}
