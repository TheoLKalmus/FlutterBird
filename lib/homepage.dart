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

class _HomePageState extends State<HomePage> {
  static double birdMov1 = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdMov1;
  bool gameHasStarted = false;
  static double barrierOne = 0;
  double barrierTwo = barrierOne + 1.6;
  double _points = 0;
  double _highPoints = 0;

  @override
  void initState(){
      gameHasStarted = false;
      birdMov1 = 0;
      time = 0;
      initialHeight = birdMov1;
      barrierOne = 1.8;
      barrierTwo = 1.8 + 1.5;
      _points = 0;
    super.initState();
  }

  void onInit(){
    setState(() {
      gameHasStarted = false;
      birdMov1 = 0;
      time = 0;
      initialHeight = birdMov1;
      barrierOne = 1.8;
      barrierTwo = 1.8 + 1.5;
      _points = 0;
    });
  }

  //INICIO DE PULO DO PASSARO
  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdMov1;
    });
  }

  //CHECAGEM DE COLISAO DE BARREIRAS
  bool checkBarrierCollision(){
    //SE A BARREIA ESTIVER ENTRE AS POSICOES // BARREIRA 1
        if (barrierOne > -0.2 && barrierOne < 0.8){
          //SE O PASSARO ESTIVER NO LOCAL X
        if(birdMov1 < -0.5 || birdMov1 > 0.5){
            return true;
        }
      }
        //SE A BARREIA ESTIVER ENTRE AS POSICOES // BARREIRA 2
      if (barrierTwo > -0.2 && barrierTwo < 0.8){
        //SE O PASSARO ESTIVER NO LOCAL X
        if(birdMov1 < -0.7 || birdMov1 > 0.7){
          return true;
        }
      }
      return false;
  }

  void startGame() {
    gameHasStarted = true;
    //CALCULO DA GRAVIDADE DO SALTO DO PASSARO
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2 * time;
      setState(() {
        birdMov1 = initialHeight - height;
        _points += 0.02;

        //LOOPING PARA EXIBIR BARREIRAS
        setState(() {
          if (barrierOne < -2) {
            barrierOne += 3.5;
          } else {
            barrierOne -= 0.05;
          }
        });
        setState(() {
          if (barrierTwo < -2) {
            barrierTwo += 3.5;
          } else {
            barrierTwo -= 0.05;
          }
        });
        //SE PASSARO CAIR NO CHAO OU COLIDIR END GAME
        if (birdMov1 > 1 || checkBarrierCollision()){
          timer.cancel();
          _showDialog();
        }
      });
    });
  }

  //JANELA E BOTAO GAMEOVER PLAYAGAIN
  void _showDialog(){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.black26,
              title: Text('GAME OVER',
                  style: TextStyle(color: Colors.white)),
              actions:[FlatButton(onPressed: () {
                if (birdMov1 > 1 || gameHasStarted == true) {
                  if (_points > _highPoints) {
                    _highPoints = _points;
                  }
                }
                onInit();
                setState(() {
                  gameHasStarted = false;
                });
                Navigator.of(context).pop();
                }, child: Text('PLAY AGAIN', style: TextStyle(color: Colors.white)))],
            );
          }
       );
  }

  //DETECTOR DE TAP
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
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
                child: Stack(
                  children: [

                    AnimatedContainer(
                      alignment: Alignment(0, birdMov1),
                      duration: Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: MyBird(),
                    ),

                    Container(
                      alignment: Alignment(0, -0.3),
                      child: gameHasStarted ? Text("") : Text(
                          "T A P   T O   P L A Y",
                          style: TextStyle(fontSize: 30,
                              color: Colors.white
                          )),
                    ),

                    //BARREIRAS DO GAME
                    AnimatedContainer(
                      alignment: Alignment(barrierOne, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 135.0,
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierOne, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 135.0,
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierTwo, 1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 115.0,
                      ),
                    ),

                    AnimatedContainer(
                      alignment: Alignment(barrierTwo, -1.1),
                      duration: Duration(milliseconds: 0),
                      child: MyBarrier(
                        size: 115.0,
                      ),
                    )

                  ],
                )),
            Container(
              height: 15,
              color: Colors.green,
            ),

            //LAYOUT DA PONTUACAO ATUAL E MELHOR PONTUACAO
            Expanded
              (child: Container(
              color: Colors.brown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SCORE", style: TextStyle(color: Colors.white,
                          fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(_points.toInt().toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("BEST", style: TextStyle(color: Colors.white,
                          fontSize: 20)),
                      SizedBox(
                        height: 20,
                      ),
                      Text(_highPoints.toInt().toString(),
                          style: TextStyle(color: Colors.white, fontSize: 35))
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