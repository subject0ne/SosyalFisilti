import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//yan menü kişisel verilerin korunması
class KisiselVeriler extends StatelessWidget {
  KisiselVeriler(String s);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar( 
        title: new Text("Kişisel Verilerin Korunması"),
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
                  height: 700,
                   //gönderi alanı uzunluğu belirlenecek
                   width: double.infinity,
                   //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                   padding: EdgeInsets.all(10),
                   //içeriden başatmak için örneğin resmin konumu içeriden başlar
                   child: new Text("KİŞİSEL VERİLERİN KORUNMASI POLİTİKASI \n 6698 sayılı KİŞİSEL VERİLERİN KORUNMASI KANUNU uyarınca Kişisel Verilerin Korunması Politikamız \n 6698 sayılı Kişisel Verilerin Korunması Kanunu (“KVKK”) ve ilgili sair mevzuat uyarınca, Sosyal Fısıltı (“SF”) olarak anılacaktır. Veri Sorumlusu sıfatıyla, kişisel bilgilerinizin aşağıda açıklandığı çerçevede; kaydedileceği, saklanacağı, güncelleneceği belirtilmiştir. Mevzuatın izin verdiği durumlarda üçüncü kişilere açıklanabileceği/aktarılabileceği ve ilgili mevzuatta belirtilen diğer usul ve esaslara göre işlenebileceği hususlarında siz değerli kullanıcılarımızı bilgilendirmek isteriz. Kişisel veriler; ad, soyad, TC kimlik numarası, adres ve iletişim bilgileri gibi sizin belirlenmenizi veya belirlenebilir olmanızı sağlayacak her türlü bilgidir. Kişisel bilgiler içeren ve kullanımı, işlenmesi veya aktarımı ilgili yasa veya düzenleme kapsamında “kişisel veri” olarak düzenlenmiş olan irtibat verilerini ifade etmektedir. Kişisel verileriniz; hizmetlerimizin talep edilmesi, devamlılığı, hizmet sonrası diğer işlemler ve sona ermesinde ortaya çıkan usulsüzlük, suistimal ve dolandırıcılık gibi durumların önlenmesi, tespit edilmesi amacı ile arşiv merkezlerinde muhafaza altında tutulacaktır. Her türlü kötü niyetli kullanımların önlenmesi ve tespit edilmesi, hizmet ve servislerimiz hakkında bilgi edinmek yasal yükümlülüklerin yerine getirilmesi ve denetim faaliyetleri amacıyla gerekli bilgilerin paylaşımı SF’nin arşivinde muhafaza altında tutulacaktır.",
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