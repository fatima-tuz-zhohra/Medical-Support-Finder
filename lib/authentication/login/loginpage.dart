import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msf/authentication/login/login_provider.dart';
import 'package:msf/authentication/signup/signup.dart';
import 'package:msf/widgets/input_field.dart';
import 'package:msf/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
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
        appBar: AppBar(
          centerTitle: true,
          elevation: 8.0,
          title: Text('LOGIN'),
        ),
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                InputField(
                      icon: Icon(Icons.mail),
                      hintText: 'E-mail',
                      controller: emailController,
                  ),
                SizedBox(height: size.height * 0.01),
                InputField(
                    icon: Icon(Icons.lock),
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                SizedBox(height: size.height * 0.02),
                RoundedButton(
                  text: 'LogIn',
                  press: () {
                    _onSignUpButtonPressed(context);
                  },
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Do not have an Account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                              return SignUp();
                            }));
                      },
                      child: Text('SignUp'),
                    )
                  ],
                ),
              ]),
        ),
    );
  }
  void _onSignUpButtonPressed(BuildContext context) {
    String email = emailController.text;
    String pass = passwordController.text;

    print("$email");
    print("$pass");

    if (emailController.text == "" ||
        passwordController.text == "") {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      /*Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return HomePage();
          }));*/
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      loginProvider.setLoggedInStatus(true);
    }
  }
}