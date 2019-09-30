import 'package:flutter/material.dart';
import 'dart:async';
import '../routes/RotaCikisYolu.dart';
import 'info.dart';


class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);
  @override
  _State createState() => new _State();
  
}

class _State extends State<Splash> {
  Duration duration = const Duration(seconds: 5); //5saniye sonra geçiş
  startTimeout() {
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    Navigator.pop(context);
    Navigator.push(
        context, RotaCikisYolu(builder: (context) => new Info()));
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Sosyal Fısıltı \n Yardımlaşma Ağı',
                textDirection: TextDirection.ltr,
                style: TextStyle(fontFamily: 'Montserrat',fontSize: 46.0, color: Colors.white, fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    ));
  }

  dispose() {
    super.dispose();
  }
}
