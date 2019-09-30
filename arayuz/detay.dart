import 'package:flutter/material.dart';

class Detay extends StatefulWidget {
  var imgPath; //degişken tag atandı resim özellikleri için
  Detay({this.imgPath}); //detaydaki bu image pathe git

  @override
  _DetayState createState() => _DetayState();
}

class _DetayState extends State<Detay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fotograflar"),
      ),
      body: Container(
        //resmin tüm alanı kaplamasını sağlar
        width: MediaQuery.of(context)
            .size
            .width, //genişliği ekranın genişliği kadar kapla
        height: MediaQuery.of(context)
            .size
            .height, //yüksekliği ekranın yüksekliği kadar kapla
        decoration: BoxDecoration(
            //
            image: DecorationImage(
                image: AssetImage(widget.imgPath),
                fit: BoxFit
                    .cover) //bu State'in bağlı olduğu widget'e git değişkeni oku
            ),
      ),
    );
  }
}
