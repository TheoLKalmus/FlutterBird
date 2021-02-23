import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first_app/barriers.dart';
import 'package:flutter_first_app/bird.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  static double birdMov1 = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdMov1;
  bool   gameHasStarted = false;
  static double barrierOne = 0;
  double barrierTwo = barrierOne + 1.6;
  int score = 0;
  int highscore = 0;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdMov1;
    });
  }

  void startGame(){
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2 * time;
      setState((){
        birdMov1 = initialHeight - height;

       setState(() {
         if (barrierOne < -1.1) {
           barrierOne += 2.8;
         } else {
           barrierOne -= 0.05;
         }
       });

        setState(() {
          if (barrierTwo < -1.1) {
            barrierTwo += 2.8;
          } else {
            barrierTwo -= 0.05;
          }
        });

      });
      if (birdMov1 > 1){
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  // Todo EXIBE SCORE E JANELA PARA REINICIO DO GAME
 /* void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.black26,
          title: Text(
            "GAME OVER",
            style: TextStyle(color: Colors.white),
          ),
          content: Text (
            "SCORE:" + score.toString(),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            FlatButton (
              child: Text(
                "PLAY AGAIN",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                if (score > highscore){
                  highscore = score;
                }
                initState();
                setState(() {
                  gameHasStarted = false;
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }*/

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        if (gameHasStarted){
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child:Stack(
              children:[

                AnimatedContainer(
                alignment: Alignment(0, birdMov1),
                duration: Duration(milliseconds: 0),
                color: Colors.blue,
                child: MyBird(),
                  ),

                Container(
                  alignment: Alignment(0, -0.3),
                  child:gameHasStarted ? Text ("") : Text(
                      "T A P   T O   P L A Y",
                      style: TextStyle(fontSize: 30,
                          color: Colors.white
                      )),
                  ),

                AnimatedContainer(
                  alignment: Alignment(barrierOne, 1.1),
                  duration: Duration(milliseconds : 0),
                  child: MyBarrier(
                    size: 135.0,
                  ),
                ),

                AnimatedContainer(
                  alignment: Alignment(barrierOne, -1.1),
                  duration: Duration(milliseconds : 0),
                  child: MyBarrier(
                    size: 135.0,
                  ),
                ),

                AnimatedContainer(
                  alignment: Alignment(barrierTwo, 1.1),
                  duration: Duration(milliseconds : 0),
                  child: MyBarrier(
                    size: 100.0,
                  ),
                ),

                AnimatedContainer(
                  alignment: Alignment(barrierTwo, -1.1),
                  duration: Duration(milliseconds : 0),
                  child: MyBarrier(
                    size: 100.0,
                  ),
                )

                ],
              )),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded
              (child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SCORE", style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(score.toString(), style: TextStyle(color: Colors.white, fontSize: 35))
                     ],
                   ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("BEST", style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(highscore.toString(), style: TextStyle(color: Colors.white, fontSize: 35))
                  ],
                ),
              ],
            ),
           ),
          ),
        ],
       ),
      ),
    );
  }
}