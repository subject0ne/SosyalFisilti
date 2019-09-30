import 'package:flutter/material.dart';

import 'detay.dart';
class FotografAlani extends StatelessWidget {
  final String title;

  FotografAlani(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
         title: new Text(title),
         ),
        body: ListView(
          padding: EdgeInsets.only(top: 15),
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: 10,),         
                InkWell(                //Inkwell efekt ve tıklanma özelliği alır
                  onTap: (){                  //fotoğrafa tıklama özelliği
                    Navigator.of(context).push(MaterialPageRoute(
                      builder:(context)=> Detay(imgPath:'assets/images/d.jpg')));  //detaydaki imgPathi al resmi ata
                  },
                  child: Container(//resim container alanı
                    height: 90,      
                    width: 125,
                    decoration: BoxDecoration( 
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/d.jpg'),
                      fit: BoxFit.cover),  //fit resmi alana sığdır
                    ),
                  ),
                ),
                SizedBox(width: 10,),         //iki resim arası boşluk -genişlik
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detay(imgPath: 'assets/images/g.jpg'))); //resmi detay sayfasına al
                  },
                  child: Container(
                    height: 90,      //resim alanı yüksekliği
                    width: 125,
                    //width: (MediaQuery.of(context).size.width-6)/3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/g.jpg'),fit: BoxFit.cover),   //resmi alana sığdır
                    ),
                  ),
                ),
                SizedBox(width: 10,),         //iki resim arası boşluk -genişlik
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detay(imgPath: 'assets/images/g.jpg'))); //resmi detay sayfasına al
                  },
                  child: Container(
                    height: 90,      //resim alanı yüksekliği
                    width: 125,
                    //width: (MediaQuery.of(context).size.width-6)/3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/g.jpg'),fit: BoxFit.cover),   //resmi alana sığdır
                    ),
                  ),
                ),

              ],

            ),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                SizedBox(width: 10,),         //iki resim arası boşluk -genişlik
                InkWell(                //Inkwell efekt ve tıklanma özelliği alır
                  onTap: (){                  //fotoğrafa tıklama özelliği
                    Navigator.of(context).push(MaterialPageRoute(builder:(context)=> Detay(imgPath:'assets/images/k2.jpg')));  //detaydaki imgPathi al resmi ata
                  },
                  child: Container(
                    height: 90,      //resim alanı yüksekliği
                    width: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/k2.jpg'),fit: BoxFit.cover),     //fit resmi alana sığdır
                    ),
                  ),
                ),
                SizedBox(width: 10,),         //iki resim arası boşluk -genişlik
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detay(imgPath: 'assets/images/m.jpg'))); //resmi detay sayfasına al
                  },
                  child: Container(
                    height: 90,      //resim alanı yüksekliği
                    width: 125,
                    //width: (MediaQuery.of(context).size.width-6)/3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/m.jpg'),fit: BoxFit.cover),   //resmi alana sığdır
                    ),
                  ),
                ),
                SizedBox(width: 10,),         //iki resim arası boşluk -genişlik
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detay(imgPath: 'assets/images/g.jpg'))); //resmi detay sayfasına al
                  },
                  child: Container(
                    height: 90,      //resim alanı yüksekliği
                    width: 125,
                    //width: (MediaQuery.of(context).size.width-6)/3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: AssetImage('assets/images/g.jpg'),fit: BoxFit.cover),   //resmi alana sığdır
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }
}