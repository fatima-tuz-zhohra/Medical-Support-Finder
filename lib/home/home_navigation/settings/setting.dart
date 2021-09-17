import 'package:flutter/material.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:msf/widgets/rounded_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: Icon(Icons.add_alert),
                title: Text('Receive Notification'),
                trailing: Switch(
                  value: true,
                  onChanged: (bool value) {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('Help & Support'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip_outlined),
                title: Text('Privacy Policy'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),
              ListTile(
                leading: Icon(Icons.content_paste_outlined),
                title: Text('Terms & Conditions'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 40),
              RoundedButton(text: 'LogOut', press: _signOut),
            ],
          ),
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
