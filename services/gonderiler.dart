import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';




class OrtaGoruntu extends StatefulWidget{
  State createState ()=> OrtaGoruntuState();
}

class OrtaGoruntuState extends State<OrtaGoruntu>{
  String SecilenSehir;
  String SecilenKonu;
  List<String> sehirler = ["Adana ","Adıyaman","Afyon","Ağrı","Amasya", "Ankara", "Antalya", "Artvin", "Aydın" ,"Balıkesir" ,"Bilecik","Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale" ,"Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir" ,"Gaziantep"];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView( //gönderilerin bulunacağı alan oluşturma
      padding: EdgeInsets.only(top: 0,bottom: 0),
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(15.0), //ana arkaplanla arasında boşluk bırakarak oluştur
          child: Material(  //gönderi altyapısı oluşturma kısmı
            borderRadius: BorderRadius.circular(16), //dikdörtgenin kenarlarını ovalleştir
            elevation: 4, //kenarlara gölgelik verir
            //color: Colors.blue.shade300, //gönderi alanı arkaplan geçici olarak görüntüleme amaçlı
            child: Container(
              height: 320,  //gönderi alanı uzunluğu belirlenecek
              width: double.infinity, //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
              padding: EdgeInsets.all(15), //içeriden başatmak için örneğin resmin konumu içeriden başlar
              child: Column( //gönderi alanı için sütun oluşturuldu
                children: <Widget>[
                  Row(
                    //yan yana gelecek elemanlar
                    children: <Widget>[
                      Container(
                          height: 30,
                          width: 98,
                          decoration: BoxDecoration(
                            //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(195),
                              //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.red),
                          child: DropdownButton<String>(items: sehirler.map((listSehir){
                            return DropdownMenuItem<String>(child: Text(listSehir), value: listSehir,);
                          }).toList(),
                            onChanged: (s){
                              setState(() {
                                SecilenSehir = s;
                              });
                            },
                            hint: Text("  Sehir",style: TextStyle(color: Colors.white),),
                            value: SecilenSehir,)
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      //şehir ile içerik butonu arası boşluk
                      Container(
                        height: 30,
                        width: 101,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          //boxdecoration dikdörtgen oluşturur//İçerik bilgisi için buton
                            borderRadius: BorderRadius.circular(110),
                            //dikdörtgenin kenarlarını ovalleştir
                            color: Colors.green),
                        child: DropdownButton<String>(
                          items: [
                            DropdownMenuItem<String>(
                              child: Text("Giysi"),
                              value: "Giysi",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Saglik"),
                              value: "Saglik",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Esya"),
                              value: "Esya",
                            ),
                            DropdownMenuItem<String>(
                              child: Text("Egitim",),
                              value: "Egitim",
                            ),
                          ],
                          onChanged: (String konumus) {
                            setState(() {
                              SecilenKonu = konumus;
                            });


                          },
                          hint: Text("  Konu",style: TextStyle(color: Colors.white),),
                          value: SecilenKonu,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),//ilk row ile gönderi metni arası boşluk ver
                  Text("Okulumuz İçin araç gereç ihtiyacı: Türkiye haritası, tahta kalemi ve silgisi Adres: Ankara mahallesi 11 sokak No:3/A Ankara ",
                    style: TextStyle(
                        fontSize: 13, fontFamily: 'Montserrat',
                        color: Colors.black),),//Gönderi metni
                  SizedBox(height: 15,),
                  Row(    //gönderi altında bulunan butonlar için açıldı
                      children: <Widget>[
                        Container(
                          height: 20,
                          width: 75,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(    //içerisine yazı
                            child: RaisedButton(child: Text('Destek Ol',style: TextStyle(
                                fontFamily: 'Montsertat',fontSize: 10,color: Colors.black
                            ),),onPressed: () => debugPrint('Destek Ol butonuna basıldı'),),
                          ),
                        ),
                        SizedBox(width: 5,), //destek ol- rezerve arası boşluk
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(child: Text('Rezerve',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 10,
                                  color: Colors.black
                              ),),onPressed: () => debugPrint('Rezerve butonuna basıldı'),),//terminalde ekrana verilen mesajdır
                          ),
                        ),
                        SizedBox(width: 5,),  //rezerve - iletişim butonu arası boşluk
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(child: Text('İletişim',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 10,
                                  color: Colors.black
                              ),),onPressed: () => debugPrint('İletişim butonuna basıldı'),),//terminalde ekrana verilen mesajdır
                          ),
                        ),
                        SizedBox(width: 5,),  //iletişim - paylaş butonu arası boşluk
                        Container(
                          height: 20,
                          width: 72,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(child: Row(
                              children: <Widget>[

                                Text('Paylaş',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 8,
                                      color: Colors.black
                                  ),),
                                Icon(Icons.arrow_forward, size: 15,),
                              ],),
                              onPressed: paylas(),
                                                          ),
                                                        ),
                              
                                                      ),]
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 130,
                                                      width: 300,
                                                      color: Colors.deepPurple,
                                                    ),
                                                  ],
                                                ),
                                              ],
                              
                                            ),
                              
                                          ),
                              
                                        ),
                              
                                      ),
                              
                                    ],
                              
                                  );
                                }
                              
                                paylas() {}
}