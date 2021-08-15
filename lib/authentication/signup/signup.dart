import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msf/authentication/login/loginpage.dart';
import 'package:msf/widgets/input_field.dart';
import 'package:msf/widgets/rounded_button.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  bool? value = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  final snackBar = SnackBar(
      content: Text('Error!'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'SIGNUP',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InputField(
                  icon: Icon(Icons.account_circle),
                  hintText: 'Name',
                  controller: nameController,
                ),
              SizedBox(height: size.height * 0.01),
               InputField(
                  icon: Icon(Icons.email),
                  hintText: 'E-mail',
                  controller: emailController,
                ),
              SizedBox(height: size.height * 0.01),
               InputField(
                  icon: Icon(Icons.phone),
                  hintText: 'Phone No',
                  controller: phoneNoController,
                ),
              SizedBox(height: size.height * 0.01),
              InputField(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  controller: passwordController,
                ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
                Text('I Accept Terms & Condition',
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                ),
              ],
              ),
              SizedBox(height: size.height * 0.02),
              RoundedButton(
                  text: 'Sign Up',
                  press: (){
                    _onSignUpButtonPressed(context);
                  },
              ),
              SizedBox(height: size.height * 0.02),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  child: Text('LogIn'),
                ),
              ])
            ],
          ),
        ));
  }

  void _onSignUpButtonPressed(BuildContext context){
    String name = nameController.text;
    String email = emailController.text;
    String phoneNo = phoneNoController.text;
    String pass = passwordController.text;

    if (nameController.text == "" ||
        emailController.text == "" ||
        phoneNoController.text == "" ||
        passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ),
      );
    }
  }
}
