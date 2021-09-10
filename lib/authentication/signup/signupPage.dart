import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:msf/authentication/signup/bloc/signup_bloc.dart';
import 'package:msf/home/home_main/homepage.dart';
import 'package:msf/widgets/input_field.dart';
import 'package:msf/widgets/rounded_button.dart';

class SignUpPage extends StatefulWidget {
  static const PATH = "/signup";

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocProvider<SignupBloc>(
        create: (context) => SignupBloc(),
        child: Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _SignUpForm(),
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

class _SignUpForm extends StatelessWidget{
  _SignUpForm({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final snackBar = SnackBar(
    content: Text('Error!'),
    backgroundColor: Colors.red,
  );

  get value => null;

  @override
  Widget build(BuildContext context){
    return BlocConsumer<SignupBloc, SignupState>(
    listener: (context, state) {
      if (state is SignupSuccessState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed Up Successfully')),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.PATH,
              (route) => false,
        );
      } else if (state is SignupFailedState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signed Up failed')),
        );
      }
    },
      builder: (context, state) {
        if (state is SignupLoadingState) {
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
            icon: Icon(Icons.account_circle_rounded),
            hintText: 'Name',
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid Name";
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.01),
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
            icon: Icon(Icons.phone),
            hintText: 'PhoneNo',
            controller: phoneNoController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter valid PhoneNo";
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
            text: 'SignUp',
            press: () {
              final isValid = _formKey.currentState?.validate();
              if (isValid == true) {
                _onSignUpButtonPressed(context);
              }
            },
          ),
          SizedBox(height: size.height * 0.02),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                          return LogInPage();
                        }));
                  },
                  child: Text('LogIn'),
                ),
              ])
        ],
      ),
    );
  }

  void _onSignUpButtonPressed(BuildContext context) {
    String name = nameController.text;
    String email = emailController.text;
    String phoneNo = phoneNoController.text;
    String pass = passwordController.text;

    //todo remove printing before release
    print("$name");
    print("$email");
    print("$phoneNo");
    print("$pass");

    final loginBloc = BlocProvider.of<SignupBloc>(context, listen: false);
    loginBloc.add(SignupWithRequiredEvent(name, email, phoneNo, pass));
  }
}