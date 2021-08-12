import 'package:flutter/material.dart';
import 'package:msf/home/home_main/settings/profile.dart';
import 'package:msf/home/home_main/settings/setting.dart';

class HomepageNavigator extends StatefulWidget {
  const HomepageNavigator({Key? key}) : super(key: key);

  @override
  _HomepageNavigatorState createState() => _HomepageNavigatorState();
}

class _HomepageNavigatorState extends State<HomepageNavigator> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Profile();
          }));
        } else if (index == 1) {
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SettingScreen();
            },
          ));
        }
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Setting',
        ),
      ],
    );
  }
}
