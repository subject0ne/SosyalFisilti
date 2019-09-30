import 'package:flutter/material.dart';
class GizlilikPolitikasi extends StatelessWidget {
  GizlilikPolitikasi(String s);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Gizlilik Poliitikası"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(6.0),
               //ana arkaplanla arasında boşluk bırakarak oluştur
            child: Material(
              //gönderi altyapısı oluşturma kısmı
                 borderRadius: BorderRadius.circular(16),
                 //dikdörtgenin kenarlarını ovalleştir
                 elevation: 4,
                 //kenarlara gölgelik verir
                 color: Colors.purple[50], //gönderi alanı arkaplan rengi
                child: Container(
                  height: 882,
                   //gönderi alanı uzunluğu belirlenecek
                   width: double.infinity,
                   //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                   padding: EdgeInsets.all(10),
                   //içeriden başatmak için örneğin resmin konumu içeriden başlar
                   child: new Text("""GİZLİLİK SÖZLEŞMESİ VE GİZLİLİK POLİTİKAMIZ \n
Sınırlı Sorumlu Sosyal Fısıltı Yardımlaşma Girişimi Üretim ve İşletme Kooperatifi (Bundan böyle “SF” olarak anılacaktır), isimli uygulama üzerinden başlatmış olduğu sosyal yardım faaliyeti ile ihtiyaç sahibi kişiler ile destekçi ve gönüllülerin aynı platformda bir araya gelmesini ve yardımlaşma faaliyetlerinin yürütülmesini hedeflemektedir. Üyeler, uygulamada bir kullanıcı profili oluşturarak ve kendi kişisel bilgileri ile kayıt yaptırarak işbu gizlilik politikasını ve gizlilik sözleşmesini kabul etmiş sayılırlar. 
Uygulama içeriği SF tarafından hazırlanmaktadır. Üyeler tarafından İnternet Sitesi’nde SF ile paylaşılmış olan kişisel bilgiler sadece ilgili sosyal yardım faaliyetinin yürütülmesi maksadıyla ilgili İhtiyaç Sahibi ya da Destekçi/Gönüllü ile paylaşılmaktadır. Bu bilgiler, genel kullanıma açık olmayan güvenli bir ortamda saklanmakta ve sadece SF bünyesinde kullanılmaktadır. \n
Uygulama, diğer internet sitelerine bağlantı vermektedir. Gizlilik Politikamız'da yer alan taahhütlerimiz sadece uygulama içerisinde geçerlidir ve diğer internet sitelerini kapsamamaktadır. Uygulamadan bağlantı ile gidilecek diğer internet sitelerindeki kullanım ile ilgili o sitelere ait gizlilik güvencesi ve kullanım şartları geçerlidir. İnternet sitesinden reklam, banner, içerik maksatlı veya başka bir maksat ile geçilen diğer internet sitelerinin bilgi kullanımı, etik ilkeleri, gizlilik prensipleri, nitelik ve servis kalitesi ile bu uygulamada oluşabilecek herhangi bir maddi / manevi zarar ve kayıplardan SF sorumlu değildir. 
Bize olan güveniniz için teşekkür ederiz. \n

Saygılarımızla 
Sınırlı Sorumlu Sosyal Fısıltı Yardımlaşma 
Girişimi Üretim ve İşletme Kooperatifi 
(“Sosyal Fısıltı”)
""",
                   style: TextStyle(
                     fontSize: 17, fontFamily: 'Montserrat', color: Colors.black
                   ),),
                ),
            ),
          ),
        ],
      ),
      
    );
  }
}