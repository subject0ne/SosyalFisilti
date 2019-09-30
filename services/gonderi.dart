import 'package:flutter/material.dart';
import 'package:fisilti_arayuz/services/authentication.dart';
import 'package:fisilti_arayuz/models/todo.dart';


class GonderiOlustur extends StatefulWidget{
  State createState()=> GonderiOlusturState();

}

class GonderiOlusturState extends State<GonderiOlustur>{
  String SecilenSehir;
  String SecilenKonu;
  List<String> sehirler = ["Adana ","Adıyaman","Afyon","Ağrı","Amasya", "Ankara", "Antalya", "Artvin", "Aydın" ,"Balıkesir" ,"Bilecik","Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale" ,"Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir" ,"Gaziantep"];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Gonderi Olustur"),backgroundColor: Colors.purple,),
      backgroundColor: Colors.white,
      body: ListView(//gönderilerin oluşacağı alanı oluşturma

        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0), //ana arkaplanla arasında boşluk bırakarak oluştur
            child: Material(  //gönderi altyapısı oluşturma kısmı
              borderRadius: BorderRadius.circular(16), //dikdörtgenin kenarlarını ovalleştir
              elevation: 4, //kenarlara gölgelik verir
              //color: Colors.blue.shade300, //gönderi alanı arkaplan geçici olarak görüntüleme amaçlı
              child: Container(
                height: 255,  //gönderi alanı uzunluğu belirlenecek
                width: double.infinity, //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                padding: EdgeInsets.all(15), //içeriden başatmak için örneğin resmin konumu içeriden başlar
                child: Column( //gönderi alanı için sütun oluşturuldu
                  children: <Widget>[
                    Row(
                      //yan yana gelecek elemanlar
                      children: <Widget>[
                        Container(
                          //gönderi profil resmi alanı
                          height: 50,
                          width: 50, //resim boyutları
                          decoration: BoxDecoration(
                            //boxdecoration dikdörtgen oluşturur
                              borderRadius: BorderRadius.circular(20),
                              //dikdörtgenin kenarlarını ovalleştir
                              image: DecorationImage(
                                  image: AssetImage('assets/images/women.jpg'),
                                  fit: BoxFit
                                      .cover) //fit verilen boşluğa resmi sığdır
                          ),
                        ),
                        //Satırın ilk elemanı bitti
                        SizedBox(
                          width: 3,
                        ),
                        //satırın ilk elemanı ile diğer gelecek eleman arasına boşluk
                        Container(
                          width: MediaQuery.of(context).size.width - 335,
                          //dinamik tanım//mümkün olan tüm değeri al her ekran özelliğine uyum sağla/değeri satırlara göre ayarlanır ekrana sığdırılır
                          child: Column(
                            //satır oluştur /gönderi yapan ad soyad alanı ilk satır ve gönderi tarihi alanı
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //column ortadan başlattığı için /yukarıdan aşağı dizilim yapan widget içinde soldan sağa düzen vermek için crossaxis.aligment kullanılır
                            children: <Widget>[
                              //isim soyisim alanı
                              Text(
                                "Adı Soyadı",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              //kullanıcı ismi ile tarih bilgisi arası boşluk ver
                              Text(
                                '30 dakika önce',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        //soldaki kullanıcı adı ve icon arası boşluk
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
                    ),  //Row bitti kullanıcı resmi,adı ,tarih
                    SizedBox(height: 15,),//ilk row ile gönderi metni arası boşluk ver
                    Text(" ",
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
                            ),),onPressed: () => debugPrint('Destek Ol butonuna basıldı'),
                              color: Colors.lightBlueAccent,),
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
                            child: RaisedButton(
                                child: Text('Rezerve',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 10,
                                      color: Colors.black
                                  ),),onPressed: () => debugPrint('Rezerve butonuna basıldı'),//terminalde ekrana verilen mesajdır
                                color: Colors.orange),
                          ),
                        ),
                        SizedBox(width: 5,),  //iletişim - paylaş butonu arası boşluk
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(
                                child: Text('Paylaş',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 10,
                                      color: Colors.black
                                  ),),onPressed: () => debugPrint('Paylaş butonuna basıldı'),//terminalde ekrana verilen mesajdır
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 2,),  //paylaş butonu - icon arası boşluk
                        Icon(
                          Icons.favorite,size: 25,color: Colors.purple.shade300,  //gönderi altında icon
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 347,
                          color: Colors.purple,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0 ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),topLeft: Radius.circular(10),),
                                      ),
                                      child: Text(
                                        "0",
                                        style: TextStyle(color: Colors.white, fontSize: 12),textAlign: TextAlign.center,
                                      ),
                                    ),
                                    height: 15,
                                    width: 60,
                                  ),
                                  Container( //ikinci icerik
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0 ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                      ),
                                      child: Text(
                                        "0",
                                        style: TextStyle(color: Colors.white,fontSize: 12),textAlign: TextAlign.center,
                                      ),
                                    ),
                                    height: 15,
                                    width: 30,
                                  ),
                                  Container(  // ucuncu icerik
                                    height: 15,
                                    width: 90,
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0 ),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),topRight: Radius.circular(10),),
                                      ),
                                      child: Text(
                                        "0",
                                        style: TextStyle(color: Colors.black,fontSize: 12),textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,size: 25,color: Colors.purple.shade300,  //gönderi altında icon

                        ),
                        //onTap: () => Navigator.of(context).pop(), // çıkışa tıklandı
                      ],
                    ),
                    SizedBox(width: 90,),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}