import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msf/home/home_main/homepage.dart';
import 'package:msf/main.dart';
import 'package:msf/authentication/signup/signup.dart';
import 'package:msf/widgets/input_field.dart';

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
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 8.0,
          title: Text('LOGIN'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: InputField(
                    icon: Icon(Icons.email),
                    hintText: 'E-mail',
                    controller: emailController,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: InputField(
                    icon: Icon(Icons.lock),
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    width: 324,
                    child: MaterialButton(
                      color: theme.colorScheme.primary,
                      onPressed: () {
                        String email = emailController.text;
                        String pass = passwordController.text;

                        print("$email");
                        print("$pass");

                        if (emailController.text == "" ||
                            passwordController.text == "") {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        }
                      },
                      child: const Text(
                        'LogIn',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

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
              ])),
        ));
  }
}