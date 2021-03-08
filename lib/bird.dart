import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Container(
      height: 90,
      width: 90,
      child: Image.asset(
      'lib/images/flappy_ston_bird.png'
        ),
    );
  }
}