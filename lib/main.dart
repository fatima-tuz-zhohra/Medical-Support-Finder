import 'package:flutter/material.dart';
import 'package:msf/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Medical Support Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(widget.title),
        title: Row(
          children: [
            Icon(
              Icons.android,
              color: Colors.white70,
              size: 20.0,
            ),
            const SizedBox(
              width: 12,
            ),
            Text('Medical Support Finder'),
          ],
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome To Our ',
            style: TextStyle(fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.indigo,
            ),
            ),

            Text('Medical Support Finder',
            style: TextStyle(fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            fontSize: 32,
            color: Colors.pinkAccent,
            ),
            ),

            Text('Application',
            style: TextStyle(fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.indigo,
            ),
            ),
            const SizedBox(height: 12,),
            Image.asset( 'assets/images/hand_support.jpg'),
            const SizedBox(height: 12,),

            Text('What is Your Need!\nThose are here...',
              style: TextStyle(fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return LoginPage();
          })
          );
        },
        child: Icon(Icons.arrow_forward_sharp),
      ),
    );
  }
}
