import 'package:fisilti_arayuz/services/gizlilikpolitikasi.dart';
import 'package:fisilti_arayuz/services/kisiselveriler.dart';
import 'package:fisilti_arayuz/services/kullanimkosullari.dart';
import 'package:flutter/material.dart';
import 'fotograflar.dart';
import 'gonderiler.dart';
import 'fotograf.dart';
import 'hakkinda.dart';
import 'package:fisilti_arayuz/services/authentication.dart';
import 'package:fisilti_arayuz/pages/root_page.dart';

class ProfileGecis extends StatefulWidget  {
  ProfileGecis({Key key, this.auth, this.userId, this.onSignedOut, this.title})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  var str;  //butonların alt içerikleri için değişkenler
  int counter = 0;
  //final String title; //???
  List<Widget> strings = [OrtaGoruntu(),FotografaGecis("Fotograf"),KisiselBilgiler()];
  //list widgetler'a method tanımlama
  var displayedString = OrtaGoruntu();

  final String title;    
  //profile geçiş değişkeni tanımlama


  @override
  State<StatefulWidget> createState() {  
    return ProfileGecisState();
  }
}

class ProfileGecisState extends State<ProfileGecis>  {


    _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();   

    } catch (e) {
      print(e);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profil"),  //title alanı profil yazısı
        ),
        drawer:  new Drawer(
          //yan açılır menü alanı oluştur
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                //kullanıcı profil alanı 
                accountName: new Text("Adı Soyadı"),
                accountEmail: new Text("gmail@gmail.com"),
                currentAccountPicture: new CircleAvatar(
                  child: Container(
                    //gönderi profil resmi alanı
                    height: 50,
                    width: 50, //resim boyutları
                    decoration: BoxDecoration(
                      //boxdecoration dikdörtgen oluşturur
                        borderRadius: BorderRadius.circular(20),
                        //dikdörtgenin kenarlarını ovalleştir
                        image: DecorationImage(
                            image: AssetImage('assets/images/women.jpg'),
                            fit: BoxFit.cover) //fit verilen boşluğa resmi sığdır
                    ),
                  ),
                ),
              ),

              new Divider(),
              new ListTile(
                title: Text("Anasayfa"), //fotoğraflar kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new RootPage(auth: new Auth()))),
              ), //ListTitle
              new ListTile(
                title: Text("Fotoğraflar"), //fotoğraflar kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new FotografAlani("Fotoğraflar"))),
              ), //ListTitle
               new ListTile(
                                  title: Text("Çıkış"), //fotoğraflar kısayolu yan menü
                                  trailing: new Icon(Icons.arrow_back_ios), //çıkış için yan ikon
                                  onTap: () {  Navigator.of(context).pop();
                                   _signOut();
                                   RootPage(auth: new Auth());
                                  }
                                           // çıkışa tıklandı yan pencere kapatılır
                                ),
                                new ListTile(
                title: Text("Kişisel Verilerin Korunması"), //anasayfa kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new KisiselVeriler("")))
                    ),
            new ListTile(
                title: Text("Kullanım Koşulları"), //anasayfa kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new KullanimKosullari("")))), 
            new ListTile(
                title: Text("Gizlilik Politikası"), //anasayfa kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                    new GizlilikPolitikasi("")))
                    ), //ListTitle//ListTitle
            ],
          ),
        ),
        backgroundColor: Colors.purple[50], //profil başlık arkaplan rengi
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            //containerı title'ın altında 0 konumda başlat
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.purple[300], //container oluştu
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        //profil resmi için container alanı
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage('assets/images/women.jpg'),
                              fit: BoxFit
                                  .cover //oluşan containera resim eklendi. Fit ile verilen alana resim sığdırıldı
                          ),
                        ),
                      ),
                      Row(
                        //profil ad soyad satırı oluştur
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Adı Soyadı"),
                        ],
                      ),
                    ],
                  ),
                ),
            Container(  //buton alanı
              color: Colors.white,  //buton arka zemini renk beyaz
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton( //ilk buton
                    child: Text("Gönderiler",style: TextStyle(color: Colors.black),),
                    shape: Border(  //buton sınırına şekil
                      bottom: BorderSide(color: Colors.purple)),  //buton alt sınıra renk
                    onPressed: (){  //buton tıklama olayı
                      setState(() { //buton içeriğinin belirlenmesi
                       icerikMethodBir(); 
                      });
                    },
                    padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                    ),//ilk buton oluştu
                    FlatButton(
                      child: Text("Gülen Yüzler",style: TextStyle(color: Colors.black),),
                      shape: Border(
                        bottom: BorderSide(color: Colors.purple),),
                      onPressed: (){  //buton tıklama olayı
                        setState(() { //buton içeriğinin belirlenmesi
                         icerikMethodIki(); 
                        });
                      },
                      padding: EdgeInsets.symmetric(
                       vertical: 10, horizontal: 20),
                     ), //ikinci buton oluştu
                     FlatButton(  //üçüncü buton
                      child: Text("Hakkında",style: TextStyle(color: Colors.black),),
                      shape: Border(
                        bottom: BorderSide(color: Colors.purple),),
                      onPressed: (){  //buton tıklama olayı
                        setState(() { //buton içeriğinin belirlenmesi
                         icerikMethodUc(); 
                        });
                      },
                      padding: EdgeInsets.symmetric(
                       vertical: 10, horizontal: 20),
                     ), //üçüncü buton oluştu

                ],
              ),
            ),
            Expanded(
                  child: Container(
                  child: widget.counter == 0 ? widget.displayedString  : widget.str
                ),
                  ),
       ],),
      ),
    ), 
  );
 }

  void icerikMethodBir() {
    //ilk butonun alt içeriği için method tanımlama
    setState(() {
      widget.str = widget.strings[0]; //[0]ilk dizi elemanını alır 
      //class alanına var str;int counter=0; List<Widget> strings = []; Değişkenler tanımlandı
      widget.counter++;    
    });
  }
  void icerikMethodIki() {
    //ilk butonun alt içeriği için method tanımlama
    setState(() {
      widget.str = widget.strings[1]; //[1]ikinci dizi elemanını alır 
      widget.counter++;    
    });
  }
  void icerikMethodUc() {
    //ilk butonun alt içeriği için method tanımlama
    setState(() {
      widget.str = widget.strings[2]; //[2]üçüncü dizi elemanını alır 
      widget.counter++;    
    });
  }

                  
                    

}


