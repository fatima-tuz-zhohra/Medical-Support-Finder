import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/widgets/rounded_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text("Edit Profile",
                  style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold)
                  ),
              ),
              SizedBox(height: 16,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'name',
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'address',
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'phoneNo',
                ),
              ),
              SizedBox(height: 20,),
              RoundedButton(text: 'Save', press: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
