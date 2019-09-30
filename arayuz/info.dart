import 'package:fisilti_arayuz/arayuz/gecis.dart';
import 'package:fisilti_arayuz/widgets/animated/ripple.dart';
import 'package:flutter/material.dart';
import 'dart:async';


class Info extends StatefulWidget {
  Info({Key key}) : super(key: key);
  @override
  InfoState createState() => new InfoState();
}

class InfoState extends State<Info> {
  Duration duration = const Duration(seconds: 3); //3 saniye sonra geçiş

  startTimeout() {
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    //Navigator.pop(context);
    Navigator.push(

        context, MaterialPageRoute(builder: (context) => new IntroScreen()));
  }

  initState() {
    super.initState();
    this.startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
          image: new DecorationImage(
        image: new AssetImage("assets/images/giris.jpg"),
        fit: BoxFit.cover,
      )),
      child: Center(
        child: Ripple(300,  //ripple halka ekler  
        child: Text('Hoşgeldiniz',
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 50.0, color: Colors.white)),
      )),
    ));
  }

  dispose() {
    super.dispose();
  }
}