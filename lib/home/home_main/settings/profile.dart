import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:msf/widgets/rounded_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class Profile {
  String name;
  String email;
  String phoneNo;
  String image;

  Profile(this.name, this.email,this.phoneNo, this.image);
}

class _ProfilePageState extends State<ProfilePage> {

  Profile profile = Profile('My name', 'My email', '', '');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    backgroundImage:
                        NetworkImage(profile.image),
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
                      subtitle: Text(profile.name),
                    ),
                  )
                ],
              ),
            ),
            RoundedButton(text: 'LogOut', press: _signOut),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LogInPage();
    }));
  }
}
