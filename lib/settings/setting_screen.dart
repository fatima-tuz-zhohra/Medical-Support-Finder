import 'package:flutter/material.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:msf/widgets/app_bar.dart';
import 'package:msf/widgets/msf_base_page_layout.dart';
import 'package:msf/widgets/rounded_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: MsfAppBar(title: 'Settings'),
        body: MsfBasePageLayout(child: mainBody()),
      ),
    );
  }

  Widget mainBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LogInPage.PATH, (route) => false);
  }
}
