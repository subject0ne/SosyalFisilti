import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import '../shapes/Circle.dart';
//ilk ekran yapılandırma
class Ripple extends StatefulWidget {
  Ripple(this.diameter, {this.child, TextDirection textDirection, TextStyle style});

  final double diameter;
  final Widget child;
  _State createState() => new _State(diameter, child);
}

class _State extends State<Ripple> with SingleTickerProviderStateMixin {
  _State(this.diameter, this.child);
  Animation<double> animation;
  AnimationController controller;
  final double diameter;
  final Widget child;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    animation = new Tween(begin: 0.0, end: diameter * 1.7).animate(controller); // tween başlangıç ​​ve bitiş değeri arasında birbirine bağlı zincir animasyon//animasyon başlat=0 bitir diameter*1.7 
    animation.addListener(() {
      setState(() {});
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.repeat();
      }
    });
    controller.forward();
  }

  Widget build(BuildContext context) {
    double d1 = (animation.value).clamp(00, diameter).toDouble(); //clamp için alt-00 ve üst-diameter limit//en üst halka hareketsiz
    double d2 =
        (animation.value - diameter * 0.33).clamp(0, diameter).toDouble();
    double d3 =
        (animation.value - diameter * 0.7).clamp(0, diameter).toDouble();
    int dInt = diameter.toInt();
    int a1 = (dInt - d1.toInt()).clamp(0, 50);      //birinci halka
    int a2 = (dInt - d2.toInt()).clamp(0, 50);      //ikinci halka
    int a3 = (dInt - d3.toInt()).clamp(0, 50);      //üçüncü halka
    return Container(
        width: diameter,
        height: diameter,
        child: Stack(children: [
          Center(
              child: Circle(
                  diameter: d1,
                  color: Colors.white.withAlpha(a1),
                  child: Circle(
                      diameter: d2,
                      color: Colors.white.withAlpha(a2),
                      child: Circle(
                        diameter: d3,
                        color: Colors.white.withAlpha(a3),
                      )))),
          Center(child: child)    //halka texte merkez konumla
        ]));
  }

  dispose() {
    controller.dispose(); //kontrolde tut
    super.dispose();
  }
}