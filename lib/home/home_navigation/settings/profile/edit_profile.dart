import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:msf/widgets/edit_input_field.dart';
import 'package:msf/widgets/rounded_button.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNoController = TextEditingController();

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
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 16,
              ),
              EditInputField(
                hintText: 'name',
                controller: nameController,
              ),
              SizedBox(
                height: 16,
              ),
              EditInputField(
                hintText: 'address',
                controller: addressController,
              ),
              SizedBox(
                height: 16,
              ),
              EditInputField(
                hintText: 'phoneNo',
                controller: phoneNoController,
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(text: 'Save ', press: () => Navigator.pop(context)),
            ],
          ),
        ),
      ),
    );
  }
}
