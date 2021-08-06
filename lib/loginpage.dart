import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:msf/home/homepage.dart';
import 'package:msf/main.dart';
import 'package:msf/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final snackBar = SnackBar(content: Text('Error!'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
            //title: Text(widget.title),
            title: Row(
          children: [
            Text('LOGIN'),
          ],
        )),
        body: SafeArea(
          child: SingleChildScrollView(
              child:
              Column( mainAxisAlignment : MainAxisAlignment.center,
                  children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white70,
                borderRadius: new BorderRadius.circular(10.0)),
                  child: Padding(
                padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                child: TextFormField(
                  controller: emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        border: OutlineInputBorder(),
                        labelText: 'Email')),
              )),
            ),
            const SizedBox(
              height: 4,
            ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration: BoxDecoration(color: Colors.white70,
                          borderRadius: new BorderRadius.circular(10.0)),
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                        child: TextFormField(
                          controller: passwordController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Password')),
                      )),
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
                  color: Colors.green,
                  onPressed: () {
                    String email = emailController.text;
                    String pass = passwordController.text;

                    print("$email");
                    print("$pass");

                    if(
                    emailController.text == "" || passwordController.text == ""
                    ){
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    else
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      }
                  },
                  child: const Text('LogIn',
                  style: TextStyle(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                      color: Colors.green
                    )
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
                Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                      primary: Colors.lightGreen,
                      onPrimary: Colors.white70,
                    ),
                    onPressed: () {},
                    child: const Text('Google'),
                  ),
                ),
                const SizedBox(width:12),
                Container(
                  height: 50,
                  width: 150,
                  child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                  ),
                  onPressed: () {},
                  child: const Text('Facebook'),
                ),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do not have an Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
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

/*

 */