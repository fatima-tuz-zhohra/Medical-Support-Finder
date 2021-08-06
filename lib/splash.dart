import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashPageScreen(),
      ),
    );
  }
}
class SplashPageScreen extends StatelessWidget{
  const SplashPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context){
    return Image.asset('assets/images/round_hand.png', height: 140, width: 140,);
  }
}
