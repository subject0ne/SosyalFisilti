import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class OrtaGoruntu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                height: 225,  //gönderi alanı uzunluğu belirlenecek
                width: double.infinity, //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                padding: EdgeInsets.all(15), //içeriden başatmak için örneğin resmin konumu içeriden başlar
                child: Column( //gönderi alanı için sütun oluşturuldu
                  children: <Widget>[
                    Row( //yan yana gelecek elemanlar
                      children: <Widget>[
                        Container(  //gönderi profil resmi alanı
                          height: 50,
                          width: 50,  //resim boyutları
                          decoration: BoxDecoration( //boxdecoration dikdörtgen oluşturur
                              borderRadius: BorderRadius.circular(20),  //dikdörtgenin kenarlarını ovalleştir
                              image: DecorationImage(image: AssetImage('assets/images/women.jpg'),fit:BoxFit.cover)//fit verilen boşluğa resmi sığdır
                          ),
                        ),//Satırın ilk elemanı bitti
                        SizedBox(width: 10,), //satırın ilk elemanı ile diğer gelecek eleman arasına boşluk
                        Container(
                          width: MediaQuery.of(context).size.width-280, //dinamik tanım//mümkün olan tüm değeri al her ekran özelliğine uyum sağla/değeri satırlara göre ayarlanır ekrana sığdırılır
                          child: Column(  //satır olutur /gönderi yapan ad soyad alanı ilk satır ve gönderi tarihi alanı
                            crossAxisAlignment: CrossAxisAlignment.start,//column ortadan başlattığı için /yukarıdan aşağı dizilim yapan widget içinde soldan sağa düzen vermek için crossaxis.aligment kullanılır
                            children: <Widget>[ //isim soyisim alanı
                              Text("Adı Soyadı",style: TextStyle(
                                  fontFamily: 'Montserrat',fontSize: 14,fontWeight: FontWeight.bold),),
                              SizedBox(height: 5,), //kullanıcı ismi ile tarih bilgisi arası boşluk ver
                              Text('30 dakika önce',style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 10,color: Colors.grey),)
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),//soldaki kullanıcı adı ve icon arası boşluk
                        Container(
                          height: 15,
                          width: 65,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(195), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: new RaisedButton(
                              child: Text('#Ankara',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 8,
                                    color: Colors.black
                                ),),onPressed: () => debugPrint('Şehir butonuna basıldı'),//terminalde ekrana verilen mesajdır
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 5,), //şehir ile içerik butonu arası boşluk
                        Container(
                          height: 15,
                          width: 60,
                          decoration: BoxDecoration(  //boxdecoration dikdörtgen oluşturur//İçerik bilgisi için buton
                              borderRadius: BorderRadius.circular(110), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(child: Text('#Eğitim',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 8,
                                  color: Colors.black
                              ),),onPressed: () => debugPrint('Eğitim butonuna basıldı'),//terminalde ekrana verilen mesajdır
                              color: Colors.green[400],),
                          ),
                        ),
                      ],

                    ),  //Row bitti kullanıcı resmi,adı ,tarih
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
                        SizedBox(width: 5,),  //rezerve - iletişim butonu arası boşluk
                        Container(
                          height: 20,
                          width: 70,
                          decoration: BoxDecoration(     //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                              borderRadius: BorderRadius.circular(300), //dikdörtgenin kenarlarını ovalleştir
                              color: Colors.brown.withOpacity(0.2)
                          ),
                          child: Center(
                            child: RaisedButton(
                              child: Text('İletişim',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 10,
                                  color: Colors.black
                              ),),onPressed: () => debugPrint('İletişim butonuna basıldı'),//terminalde ekrana verilen mesajdır
                              color: Colors.yellow[300],),
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
                        FavoriteWidget(),
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
                                      "13.000",
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
                                      "550",
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
                                      "180.000",
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
                  ],

                ),

              ),

            ),

          ),

        ],

      );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  bool _isFavorited = false;
  int _favoriteCount = 0;
  
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border)),
            color: Colors.purple[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }

}
