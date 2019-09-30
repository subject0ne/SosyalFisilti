import 'package:flutter/material.dart';

class KisiselBilgiler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.white),
            width: double.infinity,
            child: Text(
              "Referanslar",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            width: double.infinity,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontSize: 15, color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(colors: [
                Colors.pink.shade100,
                Colors.white
              ]),
            ),
            //container rengi
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.white),
            width: double.infinity,
            child: Text(
              "Kampanyalar",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            width: double.infinity,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontSize: 15, color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(colors: [
                Colors.pink.shade100,
                Colors.white
              ]),
            ),
            //container rengi
            alignment: Alignment.center,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 30,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.white),
            width: double.infinity,
            child: Text(
              "Diger Bilgiler",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 19, color: Colors.black),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            width: double.infinity,
            child: Text(
              "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontSize: 15, color: Colors.black),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(colors: [
                Colors.pink.shade100,
                Colors.white
              ]),
            ),
            //container rengi
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
