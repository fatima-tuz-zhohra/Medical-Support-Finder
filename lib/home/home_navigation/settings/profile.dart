import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:msf/data/model/profile.dart';
import 'package:msf/services/database.dart';
import 'package:msf/widgets/rounded_button.dart';

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
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white70,
                backgroundImage: NetworkImage(profile.image),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Name'),
                  subtitle: Text(profile.name),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text('E-mail'),
                  subtitle: Text(profile.email),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.call),
                  title: Text('Phone No'),
                  subtitle: Text(profile.phoneNo),
                ),
              ),
              _createBloodDonorCard(context, profile),
            ],
          ),
        ),
        RoundedButton(text: 'LogOut', press: _signOut),
      ],
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LogInPage();
    }));
  }

 Widget _createBloodDonorCard(BuildContext context, Profile profile) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.call),
        trailing: Switch(
            value: profile.isBloodDonor,
            onChanged: (newValue) async {
              final firebaseUser = FirebaseAuth.instance.currentUser;
              final service =
              DatabaseService(uid: firebaseUser?.uid ?? '');
              if(newValue == true) {
                await service.becomeBloodDonor(profile);
              }else {
                await service.removeBloodDonor();
              }
              setState(() {});
            }),
        title: Text('Donate Blood'),
        subtitle: Text(profile.isBloodDonor ? 'Yes' : 'No'),
      ),
    );
  }
}
