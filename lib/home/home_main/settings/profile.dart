import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> entries = ['name', 'mobile no', 'email', 'password'];
  final List<String> userentries = [
    'ftz',
    '01408-485584',
    'ftzelma@gmail.com',
    'ftzelma'
  ];
  List<IconData> icon = [
    Icons.account_circle,
    Icons.phone,
    Icons.email,
    Icons.lock,
  ];

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
                    radius: 50,
                    backgroundColor: Colors.white70,
                    backgroundImage:
                        NetworkImage(userBloc.appUser?.picture ?? ''),
                  ),
                  Text(userBloc.appUser?.name??''),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Icon(icon[index]),
                        title: Text('${entries[index]}'),
                        subtitle: Text('${userentries[index]}'),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
