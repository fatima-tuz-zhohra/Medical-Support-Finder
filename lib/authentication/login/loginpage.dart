import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msf/authentication/auth_provider.dart';
import 'package:msf/authentication/signup/signup.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/widgets/input_field.dart';
import 'package:msf/widgets/rounded_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const PATH = "/login";

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(AppConstants.app_name,
                      style: theme.textTheme.headline5?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold)),
                  _LoginForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  _LoginForm({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final snackBar = SnackBar(
    content: Text('Error!'),
    backgroundColor: Colors.red,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputField(
            icon: Icon(Icons.mail),
            hintText: 'E-mail',
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid email";
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.01),
          InputField(
            icon: Icon(Icons.lock),
            hintText: 'Password',
            controller: passwordController,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid password";
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.02),
          RoundedButton(
            text: 'LogIn',
            press: () {
              final isValid = _formKey.currentState?.validate();
              if (isValid == true) {
                _onLoginButtonPressed(context);
              }
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
        ],
      ),
    );
  }

  void _onLoginButtonPressed(BuildContext context) {
    String email = emailController.text;
    String pass = passwordController.text;

    //todo remove printing before release
    print("$email");
    print("$pass");

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.loginWithEmailPass(email, pass);
  }
}
