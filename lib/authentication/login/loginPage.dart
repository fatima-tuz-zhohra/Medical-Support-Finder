import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/login/bloc/login_bloc.dart';
import 'package:msf/authentication/signup/signupPage.dart';
import 'package:msf/data/constant.dart';
import 'package:msf/home/home_navigation/homepage.dart';
import 'package:msf/widgets/input_field.dart';
import 'package:msf/widgets/rounded_button.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LogInPage extends StatefulWidget {
  static const PATH = "/login";

  @override
  State<StatefulWidget> createState() {
    return _LogInPageState();
  }
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Scaffold(
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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logged In Successfully')),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.PATH,
            (route) => false,
          );
        } else if (state is LoginFailedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Logged In failed')),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return CircularProgressIndicator();
        } else {
          return _getBody(context);
        }
      },
    );
  }

  Widget _getBody(BuildContext context) {
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
          SignInButton(
            Buttons.Google,
            onPressed: () {
              final loginBloc =
                  BlocProvider.of<LoginBloc>(context, listen: false);
              loginBloc.add(LoginWithGoogleEvent());
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
                    return SignUpPage();
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

    final loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);
    loginBloc.add(LoginWithEmailPassEvent(email, pass));
  }
}
