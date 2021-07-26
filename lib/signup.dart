import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msf/loginpage.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  bool? value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          leading: Icon(Icons.arrow_back, color: Colors.blue),
          title: Text(
            'SIGNUP',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_circle),
                        filled: true,
                        //fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(),
                        labelText: 'Name')),
              ),
              const SizedBox(
                height: 4,
              ),
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
                        prefixIcon: Icon(Icons.phone),
                        filled: true,
                        //fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(),
                        labelText: 'Phone No')),
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
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    )),
              ]),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 50,
                width: 324,
                child: MaterialButton(
                color: Colors.lightGreen,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                child: const Text('SignUp',
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

              const SizedBox(
                height: 12,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
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
}
