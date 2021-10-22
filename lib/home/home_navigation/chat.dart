import 'package:flutter/material.dart';

class Chatting extends StatefulWidget {
  const Chatting({Key? key}) : super(key: key);

  @override
  _ChattingState createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat'),
      ),
      body:
      SafeArea(
        child: SingleChildScrollView(
            child: Center(
              child:
                Text("Chatting Screen"),)
            )),
    );
  }
}
