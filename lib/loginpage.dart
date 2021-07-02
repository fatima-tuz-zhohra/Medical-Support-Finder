import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
            //title: Text(widget.title),
            title: Row(
          children: [
            Icon(
              Icons.star,
              color: Colors.black,
              size: 20.0,
            ),
            const SizedBox(
              width: 30,
            ),
            Text('LOGIN'),
          ],
        )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        //fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(),
                        labelText: 'Email')),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        filled: true,
                        //fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(),
                        labelText: 'Password')),
              ),
              const SizedBox(
                height: 4,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return HomePage();
                      })
                  );
                },
                child: const Text('LogIn'),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                      //textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                    child: const Text('Google'),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                      //textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                    child: const Text('Facebook'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Do not have an Account?'),
                  TextButton(
                      onPressed:(){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SignUp();
                            })
                        );
                  },
                    child: Text('SignUp'),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
