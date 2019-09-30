import 'dart:io';
import 'package:fisilti_arayuz/arayuz/profil.dart';
import 'package:fisilti_arayuz/pages/root_page.dart';
import 'package:fisilti_arayuz/services/gizlilikpolitikasi.dart';
import 'package:fisilti_arayuz/services/kisiselveriler.dart';
import 'package:fisilti_arayuz/services/kullanimkosullari.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; //kütüphane tanımlaması
import 'fotograflar.dart';
import 'profil.dart';
import 'package:fisilti_arayuz/services/authentication.dart';
import 'package:fisilti_arayuz/models/todo.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fisilti_arayuz/Firestore/kullanici.dart';
import 'package:fisilti_arayuz/modelsVT/vt_uye.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String SecilenSehir;
  String SecilenKonu;
  List<String> sehirler = [
    "Adana ",
    "Adıyaman",
    "Afyon",
    "Ağrı",
    "Amasya",
    "Ankara",
    "Antalya",
    "Artvin",
    "Aydın",
    "Balıkesir",
    "Bilecik",
    "Bingöl",
    "Bitlis",
    "Bolu",
    "Burdur",
    "Bursa",
    "Çanakkale",
    "Çankırı",
    "Çorum",
    "Denizli",
    "Diyarbakır",
    "Edirne",
    "Elazığ",
    "Erzincan",
    "Erzurum",
    "Eskişehir",
    "Gaziantep"
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _icerikKtrl = TextEditingController();
  final _miktarKtrl = TextEditingController();
  final d_miktarKtrl = TextEditingController();
  String city;
  String kateg;
  final Firestore _firestore = Firestore.instance;
  File _secilenResim;
  var iceriks;

  crudMedthods crudObj = new crudMedthods();

  bool _isEmailVerified = false;
  String _userId = "";

  @override
  void initState() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user?.uid;
        }
      });
    });
    crudObj.getData().then((sonuclar) {
      setState(() {
        iceriks = sonuclar;
      });
    });
    super.initState();

    _checkEmailVerification();
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailDialog();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  void _showVerifyEmailDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hesap Doğrulanmamış."),
          content: new Text("Lütfen Hesabınızı Doğrulayın."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Yeni link gönder."),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Yoksay"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Hesap Doğrulama"),
          content: new Text("Doğrulama linki e-mailinize gönderildi."),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Tamam"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    //   _onTodoAddedSubscription.cancel();
    //   _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  _yeniFisiltiEkle(String icerk, String _mktr, String shr, String katgri) {
    String icerikID = _firestore.collection("users").document().documentID;
    Map<String, dynamic> fisilticiekle = Map();
    fisilticiekle['_userId'] = "$_userId";
    fisilticiekle['_icerikId'] = "$icerikID";
    fisilticiekle['icerik'] =
        "$icerk"; // !!!  kullaniciya bağlı veri ekleme alanı
    fisilticiekle['ihtiyacMiktar'] = int.parse(_mktr);
    fisilticiekle['sehir'] = "$shr";
    fisilticiekle['kategori'] =
        "$katgri"; // !!!  kullaniciya bağlı veri ekleme alanı
    fisilticiekle['destekmiktar'] = 0;
    fisilticiekle['paylasilanzaman'] =
        FieldValue.serverTimestamp().toString(); //paylasilan zamanı

    _firestore
        .collection("users")
        .document("$icerikID")
        .setData(fisilticiekle)
        .then((v) => debugPrint("icerik eklendi $icerikID "));
  }

  DateTime date;
  _destekolbuton() async {
    _icerikKtrl.clear();
    _miktarKtrl.clear();
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Column(children: <Widget>[
            new Expanded(
                child: new TextField(
              controller: _icerikKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Adınız soy adınız',
              ),
            )),
            //Row bitti kullanıcı resmi,adı ,tarih
            new Expanded(
                child: new TextField(
              controller: _icerikKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'E-mail',
              ),
            )),

            new Expanded(
                child: new TextField(
              controller: _icerikKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Telefon numaranız',
              ),
            )),
            new Expanded(
                child: new TextField(
              controller: d_miktarKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Destek adedi',
              ),
            )),
            new Expanded(
                child: new TextField(
              controller: _icerikKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Kargo numarası/Gönderi takip numarası.',
              ),
            )),

            new FlatButton(
                child: const Text('İptal et.'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('Paylaş'),
                onPressed: () {
                  _destekekle(d_miktarKtrl.text.toString());
                  Navigator.pop(context);
                })
          ]),
        );
      },
    );
  }

  void _destekekle(String ynidestk) {
    //desteğin anlık takibi
    final DocumentReference
        destekref = //dokumani ref aliyoruz  get update set docid
        _firestore
            .document("users/$_userId"); //gibi verilere ref ile ulaşılabilir

    _firestore.runTransaction((Transaction transaction) async {
      //güncelleme işlemleri
      DocumentSnapshot destekdata = await destekref
          .get(); // snap ile dosya var mı .data ile tek tek güncelleme

      if (destekdata.exists) {
        var ihtiyacmiktari =
            destekdata.data['ihtiyacmiktar']; //güncelleme işlemleri
        var destekmiktari =
            destekdata.data['destekmiktar']; //güncelleme işlemleri
        if (ihtiyacmiktari >= destekmiktari + int.parse(ynidestk)) {
          return AlertDialog(
            title: new Text("Destek Ol."),
            content: new Text(
                "Yeterli Destek Alındı.\nYardımlarınız İçin Teşekkürler"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Tamam"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          await transaction.update(destekref,
              {'destekmiktar': (destekmiktari + int.parse(ynidestk))});
        }
      } else {
        debugPrint('İçerik bulunamadı.');
      }
    });
  }

  iceriksil() {
    _firestore.document("icerik/$_userId").delete().catchError(
          () => AlertDialog(
                content: new Text("İcerik Silinirken Hata Oluştu."),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Tamam"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
  }

  _icerikekle(BuildContext context) async {
    _icerikKtrl.clear();
    _miktarKtrl.clear();
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: new Column(children: <Widget>[
            Row(
              children: <Widget>[
                new Expanded(
                  child: DropdownButton<String>(
                    items: sehirler.map((listSehir) {
                      return DropdownMenuItem<String>(
                        child: Text(listSehir),
                        value: listSehir,
                      );
                    }).toList(),
                    onChanged: (s) {
                      setState(() {
                        SecilenSehir = s;
                      });
                    },
                    hint: Text(
                      "  Sehir",
                      style: TextStyle(color: Colors.white),
                    ),
                    value: SecilenSehir,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                //şehir ile içerik butonu arası boşluk

                DropdownButton<String>(
                  items: [
                    DropdownMenuItem<String>(
                      child: Text(" Giysi"),
                      value: " Giysi",
                    ),
                    DropdownMenuItem<String>(
                      child: Text(" Saglik"),
                      value: " Saglik",
                    ),
                    DropdownMenuItem<String>(
                      child: Text(" Esya"),
                      value: " Esya",
                    ),
                    DropdownMenuItem<String>(
                      child: Text(
                        " Egitim",
                      ),
                      value: " Egitim",
                    ),
                  ],
                  onChanged: (String konumus) {
                    setState(() {
                      SecilenKonu = konumus;
                    });
                  },
                  hint: Text(
                    "  Konu",
                    style: TextStyle(color: Colors.white),
                  ),
                  value: SecilenKonu,
                ),
              ],
            ),
            //Row bitti kullanıcı resmi,adı ,tarih

            new Expanded(
                child: new TextField(
              controller: _icerikKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'Fısıltı Çağrısı oluştur',
              ),
            )),
            new Expanded(
                child: new TextField(
              controller: _miktarKtrl,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: 'İhtiyaç adedi',
              ),
            )),

            Row(
              children: <Widget>[
                new FlatButton(
                    child: const Text('İptal et.'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new FlatButton(
                    child: const Text('Paylaş'),
                    onPressed: () {
                      _yeniFisiltiEkle(
                          _icerikKtrl.text.toString(),
                          _miktarKtrl.text.toString(),
                          SecilenSehir,
                          SecilenKonu);
                      Navigator.pop(context);
                    })
              ],
            )
          ]),
        );
      },
    );
  }

  Widget _iceriklerinAkisi() {
    if (iceriks != null) {
      return StreamBuilder(
          stream: iceriks,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) { 

                  if (city == snapshot.data.documents[i].data['sehir'] &&
                      kateg == snapshot.data.documents[i].data['kategori']) {
                    //if (kateg==snapshot.data.documents[i].data['sehir'] ) {
                    return   SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), //ana arkaplanla arasında boşluk bırakarak oluştur
                      child: Material(
                        //gönderi altyapısı oluşturma kısmı
                        borderRadius: BorderRadius.circular(
                            16), //dikdörtgenin kenarlarını ovalleştir
                        elevation: 4, //kenarlara gölgelik verir
                        //color: Colors.blue.shade300, //gönderi alanı arkaplan geçici olarak görüntüleme amaçlı
                        child: Container(
                          height: 310, //gönderi alanı uzunluğu belirlenecek
                          width: double
                              .infinity, //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                          padding: EdgeInsets.all(
                              16), //içeriden başatmak için örneğin resmin konumu içeriden başlar
                          child: Column(
                            //gönderi alanı için sütun oluşturuldu
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
                                        borderRadius: BorderRadius.circular(
                                            20), //dikdörtgenin kenarlarını ovalleştir
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/women.jpg'),
                                            fit: BoxFit
                                                .cover) //fit verilen boşluğa resmi sığdır
                                        ),
                                  ), //Satırın ilk elemanı bitti
                                  SizedBox(
                                    width: 10,
                                  ), //satırın ilk elemanı ile diğer gelecek eleman arasına boşluk
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        280, //dinamik tanım//mümkün olan tüm değeri al her ekran özelliğine uyum sağla/değeri satırlara göre ayarlanır ekrana sığdırılır
                                    child: Column(
                                      //satır oluştur /gönderi yapan ad soyad alanı ilk satır ve gönderi tarihi alanı
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, //column ortadan başlattığı için /yukarıdan aşağı dizilim yapan widget içinde soldan sağa düzen vermek için crossaxis.aligment kullanılır
                                      children: <Widget>[
                                        //isim soyisim alanı
                                        Text(
                                          "${snapshot.data.documents[i].data['_userId'].toString()}",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ), //kullanıcı ismi ile tarih bilgisi arası boşluk ver
                                        Text(
                                          '${snapshot.data.documents[i].data['paylasilanzaman'].toString()}',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ), //soldaki kullanıcı adı ve icon arası boşluk
                                  Container(
                                    height: 15,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            195), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.transparent
                                            .withOpacity(0.2)),
                                    child: Center(
                                      child: new RaisedButton(
                                          child: Text(
                                            '${snapshot.data.documents[i].data['sehir'].toString()}',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 8,
                                                color: Colors.black),
                                          ),
                                          onPressed: () => debugPrint(
                                              'Şehir butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                          color:
                                              Colors.white), //şehir buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //şehir ile içerik butonu arası boşluk
                                  Container(
                                    height: 15,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluşturur//İçerik bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            110), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                        child: Text(
                                          '${snapshot.data.documents[i].data['kategori']}',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 8,
                                              color: Colors.white //text rengi
                                              ),
                                        ),
                                        onPressed: () => debugPrint(
                                            'Eğitim butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                        color: Colors.green[400],
                                      ), //buton rengi
                                    ),
                                  ),
                                ],
                              ), //Row bitti kullanıcı resmi,adı ,tarih
                              SizedBox(
                                height: 15,
                              ), //ilk row ile gönderi metni arası boşluk ver
                              Text(
                                "${snapshot.data.documents[i].data['icerik'].toString()} ",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ), //Gönderi metni
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                //gönderi altında bulunan butonlar için açıldı
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      //içerisine yazı
                                      child: RaisedButton(
                                        child: Text(
                                          'Destek Ol',
                                          style: TextStyle(
                                              fontFamily: 'Montsertat',
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        onPressed: () =>
                                            _destekolbuton(), //terminalde ekrana verilen mesajdır
                                        color: Colors.lightBlueAccent,
                                      ), //destek ol buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //destek ol- rezerve arası boşluk
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                          child: Text(
                                            'Rezerve',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                          onPressed: () => debugPrint(
                                              'Rezerve butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                          color: Colors
                                              .orange), //rezerve buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //rezerve - iletişim butonu arası boşluk
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                        child: Text(
                                          'Paylaş',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        onPressed: () => debugPrint(
                                            'Paylaş butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ), //paylaş butonu - icon arası boşluk
                                  FavoriteWidget(),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 70,
                                width: 347,
                                color: Colors.purple,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      //ilk icerik
                                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "${snapshot.data.documents[i].data['ihtiyacMiktar'].toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 60,
                                    ),
                                    Container(
                                      //ikinci icerik
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                        ),
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 30,
                                    ),
                                    Container(
                                      // ucuncu icerik
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 90,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          //yazi icerikk
                                          margin:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 7,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.orange,
                                                radius: 7,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 7,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //yazi icerikk
                                          margin:
                                              EdgeInsets.fromLTRB(5, 10, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Gönderilen",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 13),
                                                child: Text(
                                                  "Rezerve",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 23),
                                                child: Text(
                                                  "Kalan",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  } else if (city == null) {
                    return  SingleChildScrollView(
                        child: Padding(
                      padding: const EdgeInsets.all(
                          16.0), //ana arkaplanla arasında boşluk bırakarak oluştur
                      child: Material(
                        //gönderi altyapısı oluşturma kısmı
                        borderRadius: BorderRadius.circular(
                            16), //dikdörtgenin kenarlarını ovalleştir
                        elevation: 4, //kenarlara gölgelik verir
                        //color: Colors.blue.shade300, //gönderi alanı arkaplan geçici olarak görüntüleme amaçlı
                        child: Container(
                          height: 310, //gönderi alanı uzunluğu belirlenecek
                          width: double
                              .infinity, //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                          padding: EdgeInsets.all(
                              16), //içeriden başatmak için örneğin resmin konumu içeriden başlar
                          child: Column(
                            //gönderi alanı için sütun oluşturuldu
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
                                        borderRadius: BorderRadius.circular(
                                            20), //dikdörtgenin kenarlarını ovalleştir
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/women.jpg'),
                                            fit: BoxFit
                                                .cover) //fit verilen boşluğa resmi sığdır
                                        ),
                                  ), //Satırın ilk elemanı bitti
                                  SizedBox(
                                    width: 10,
                                  ), //satırın ilk elemanı ile diğer gelecek eleman arasına boşluk
                                  Container(
                                    width: MediaQuery.of(context).size.width -
                                        280, //dinamik tanım//mümkün olan tüm değeri al her ekran özelliğine uyum sağla/değeri satırlara göre ayarlanır ekrana sığdırılır
                                    child: Column(
                                      //satır oluştur /gönderi yapan ad soyad alanı ilk satır ve gönderi tarihi alanı
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start, //column ortadan başlattığı için /yukarıdan aşağı dizilim yapan widget içinde soldan sağa düzen vermek için crossaxis.aligment kullanılır
                                      children: <Widget>[
                                        //isim soyisim alanı
                                        Text(
                                          "${snapshot.data.documents[i].data['_userId'].toString()}",
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ), //kullanıcı ismi ile tarih bilgisi arası boşluk ver
                                        Text(
                                          '${snapshot.data.documents[i].data['paylasilanzaman'].toString()}',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ), //soldaki kullanıcı adı ve icon arası boşluk
                                  Container(
                                    height: 15,
                                    width: 65,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            195), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.transparent
                                            .withOpacity(0.2)),
                                    child: Center(
                                      child: new RaisedButton(
                                          child: Text(
                                            '${snapshot.data.documents[i].data['sehir'].toString()}',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 8,
                                                color: Colors.black),
                                          ),
                                          onPressed: () => debugPrint(
                                              'Şehir butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                          color:
                                              Colors.white), //şehir buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //şehir ile içerik butonu arası boşluk
                                  Container(
                                    height: 15,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluşturur//İçerik bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            110), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                        child: Text(
                                          '${snapshot.data.documents[i].data['kategori']}',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 8,
                                              color: Colors.white //text rengi
                                              ),
                                        ),
                                        onPressed: () => debugPrint(
                                            'Eğitim butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                        color: Colors.green[400],
                                      ), //buton rengi
                                    ),
                                  ),
                                ],
                              ), //Row bitti kullanıcı resmi,adı ,tarih
                              SizedBox(
                                height: 15,
                              ), //ilk row ile gönderi metni arası boşluk ver
                              Text(
                                "${snapshot.data.documents[i].data['icerik'].toString()} ",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black),
                              ), //Gönderi metni
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                //gönderi altında bulunan butonlar için açıldı
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      //içerisine yazı
                                      child: RaisedButton(
                                        child: Text(
                                          'Destek Ol',
                                          style: TextStyle(
                                              fontFamily: 'Montsertat',
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        onPressed: () =>
                                            _destekolbuton(), //terminalde ekrana verilen mesajdır
                                        color: Colors.lightBlueAccent,
                                      ), //destek ol buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //destek ol- rezerve arası boşluk
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                          child: Text(
                                            'Rezerve',
                                            style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                          onPressed: () => debugPrint(
                                              'Rezerve butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                          color: Colors
                                              .orange), //rezerve buton rengi
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ), //rezerve - iletişim butonu arası boşluk
                                  Container(
                                    height: 20,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        //boxdecoration dikdörtgen oluştururŞehir bilgisi için buton
                                        borderRadius: BorderRadius.circular(
                                            300), //dikdörtgenin kenarlarını ovalleştir
                                        color: Colors.brown.withOpacity(0.2)),
                                    child: Center(
                                      child: RaisedButton(
                                        child: Text(
                                          'Paylaş',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Colors.black),
                                        ),
                                        onPressed: () => debugPrint(
                                            'Paylaş butonuna basıldı'), //terminalde ekrana verilen mesajdır
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ), //paylaş butonu - icon arası boşluk
                                  FavoriteWidget(),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 70,
                                width: 347,
                                color: Colors.purple,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      //ilk icerik
                                      margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlueAccent,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "${snapshot.data.documents[i].data['ihtiyacMiktar'].toString()}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 60,
                                    ),
                                    Container(
                                      //ikinci icerik
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                        ),
                                        child: Text(
                                          "0",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 30,
                                    ),
                                    Container(
                                      // ucuncu icerik
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      height: 15,
                                      width: 90,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Container(
                                          //yazi icerikk
                                          margin:
                                              EdgeInsets.fromLTRB(10, 10, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundColor: Colors.blue,
                                                radius: 7,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.orange,
                                                radius: 7,
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 7,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          //yazi icerikk
                                          margin:
                                              EdgeInsets.fromLTRB(5, 10, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              Text(
                                                "Gönderilen",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 13),
                                                child: Text(
                                                  "Rezerve",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 23),
                                                child: Text(
                                                  "Kalan",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
                  } else {
                    return Center(
                        child: Text(
                      "Kaynak Bulunamadı .",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 0.0),
                    ));
                  }
                },
              );
            }
          });
    } else {
      return Center(
          child: Text(
        "Merhaba, henüz veri eklenmedi",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: FlatButton(
              child: Text(
                'Anasayfa',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    color: Colors.white //text rengi
                    ),
              ),
              onPressed: () => _anasayfasifirla(),
              color: Colors.purple[300],
            ),
            backgroundColor: Colors.purple[400], //title arkaplan rengi
            elevation: 0,
            actions: <Widget>[
              DropdownButton<String>(
                items: sehirler.map((listSehir) {
                  return DropdownMenuItem<String>(
                    child: Text(listSehir),
                    value: listSehir,
                  );
                }).toList(),
                onChanged: (a) {
                  setState(() {
                    city = a;
                  });
                },
                hint: Text(
                  "  Sehir",
                  style: TextStyle(color: Colors.white),
                ),
                value: city,
              ),

              SizedBox(
                width: 2,
              ),
              //şehir ile içerik butonu arası boşluk

              DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                    child: Text(" Giysi"),
                    value: " Giysi",
                  ),
                  DropdownMenuItem<String>(
                    child: Text(" Saglik"),
                    value: " Saglik",
                  ),
                  DropdownMenuItem<String>(
                    child: Text(" Esya"),
                    value: " Esya",
                  ),
                  DropdownMenuItem<String>(
                    child: Text(
                      " Egitim",
                    ),
                    value: " Egitim",
                  ),
                ],
                onChanged: (b) {
                  setState(() {
                    kateg = b;
                  });
                },
                hint: Text(
                  "  Konu",
                  style: TextStyle(color: Colors.white),
                ),
                value: kateg,
              ),
            ]),
        drawer: new Drawer(
          //yan açılır menü alanı oluştur
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                //kullanıcı profil alanı 
                accountName: new Text("Adı Soyadı"),
                accountEmail: new Text("${_userId}"),
                currentAccountPicture: new CircleAvatar(
                  child: Container(
                    //gönderi profil resmi alanı
                    height: 50,
                    width: 50, //resim boyutları
                    decoration: BoxDecoration(
                        //boxdecoration dikdörtgen oluşturur
                        borderRadius: BorderRadius.circular(
                            20), //dikdörtgenin kenarlarını ovalleştir
                        image: DecorationImage(
                            image: AssetImage('assets/images/women.jpg'),
                            fit:
                                BoxFit.cover) //fit verilen boşluğa resmi sığdır
                        ),
                  ),
                ),
              ),

              new Divider(),
              new ListTile(
                  title: Text("Profil"), //anasayfa kısayolu yan menü
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ProfileGecis()))), //ListTitle
              new ListTile(
                title: Text("Fotoğraflar"), //fotoğraflar kısayolu yan menü
                onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new FotografAlani("Fotoğraflar"))),
              ), //ListTitle
              new ListTile(
                  title: Text("Çıkış"), //fotoğraflar kısayolu yan menü
                  trailing:
                      new Icon(Icons.arrow_back_ios), //çıkış için yan ikon
                  onTap: () {
                    Navigator.of(context).pop();
                    _signOut();
                    RootPage(auth: new Auth());
                  }
                  // çıkışa tıklandı yan pencere kapatılır
                  ),
              new ListTile(
                  title: Text(
                      "Kişisel Verilerin Korunması"), //anasayfa kısayolu yan menü
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new KisiselVeriler("")))),
              new ListTile(
                  title:
                      Text("Kullanım Koşulları"), //anasayfa kısayolu yan menü
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new KullanimKosullari("")))),
              new ListTile(
                  title:
                      Text("Gizlilik Politikası"), //anasayfa kısayolu yan menü
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new GizlilikPolitikasi("")))), //ListTitle
            ],
          ),
        ),
        body: _iceriklerinAkisi(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _icerikekle(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  _anasayfasifirla() {
    setState(() {
      city = null;
      kateg = null;
    });
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
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
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
