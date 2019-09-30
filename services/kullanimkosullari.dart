import 'package:flutter/material.dart';
//yan menü kullanım koşulları
class KullanimKosullari extends StatelessWidget {
  KullanimKosullari(String s);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Kullanım Koşulları"),
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
                  height: 4500,
                   //gönderi alanı uzunluğu belirlenecek
                   width: double.infinity,
                   //gönderi alanı genişliği tüm alanı alır resmi yerleştirmek için
                   padding: EdgeInsets.all(10),
                   //içeriden başatmak için örneğin resmin konumu içeriden başlar
                   child: new Text("""KULLANIM KOŞULLARI \n
 1. Taraflar\n
1.1. İşbu Kullanıcı Sözleşmesi (“Sözleşme”)  SF tarafından yönetilmekte olan www.sosyalfısıltı.org içerisinde yer alan Platform’dan faydalanan İhtiyaç Sahibi Kişiler ile (“Kullanıcı”) arasında akdedilmektedir,\n
1.2. Kullanıcılar, SF Kullanıcı Sözleşmesi’nin (“Sözleşme”) kendileri tarafından onaylanması ile yürürlüğe gireceğini ve bu koşullara uygun davranmakla yükümlü olduklarını bilmektedirler\n 
 
 2. Tanımlar\n
“Platform”; uygulama kapsamında yer alan, çeşitli konulardaki ihtiyaçların ihtiyaç sahipleri ile ihtiyacı karşılamak isteyen kişiler ve kurumların buluşmasını sağlayan dijital platformu,\n
“Kullanıcı” veya “İhtiyaç Sahibi Kullanıcı”; İhtiyaç sahibi olarak uygulamadan yararlanmak üzere uygulamayı kullanan kişiyi ifade eder. \n
  
 3. Sözleşme’nin Konusu ve Kapsamı\n
SF, uygulama üzerinde; Türkiye’de kişiler veya kurumlar tarafından talep edilen ihtiyaçların uygulamada yine kişiler veya kurumlar tarafından sistematik bir şekilde açıklanması, karşılanması ve böylelikle söz konusu ihtiyaçların gerekli kurum/kuruluş veya özel kişiler tarafından öğrenilmesinin kolaylaştırılması amacını kapsamaktadır. Farklı konularda destek vermek isteyen kişi veya kurumaların da sundukları desteklerinin kapsam ve miktarını yine platformda yayınlanacaktır. \n
İşbu Sözleşme’nin konusu; kullanıcıların söz konusu uygulamadan yararlanmasına ilişkin hüküm ve koşulları belirlenmesi ve bu doğrultuda tarafların hak ve yükümlülüklerini düzenlenmesidir.  
 
  4. Kullanıcının Hak ve Yükümlülükleri\n
4.1 Uygulamada bulunan üyelik formunun talep edilen içeriklerin gerçek bilgilerle doldurulması ve/veya kullanıcının hesabı üzerinden giriş yapması ve işbu sözleşmenin kabul edilmesi ile kullanıcı statüsü başlamaktadır. Kullanıcı statüsünün kazanılması için başvuruda bulunan gerçek kişi kullanıcının  [18 ] yaşından büyük olması gereklidir.  \n 
4.2 SF tamamen kendi iradesi doğrultusunda ve herhangi bir sebebe dayanmadan kullanıcı başvurularını reddedebilir veya kullanıcı başvurusunun kabul edilmesini ek şart ve koşullara bağlayabilir. SF, işbu sözleşme ve belirtilen kural ve koşullara aykırılık, kullanıcı başvurusu sırasında verilen bilgilerin yeterli, doğru veya güncel olmadığının tespit edilmesi halinde üyelik reddedilecektir.\n
 Kişinin başvurusunun daha önce reddedilmiş olması, kullanıcı hakkında şikâyetlerin alınması vb. sebepler dâhil olmak üzere, haklı bir sebebe dayanarak veya herhangi bir sebebe dayanmadan ve herhangi bir bildirimde bulunmadan, her zaman herhangi bir tazminat yükümlülüğü altında bulunmaksızın işbu sözleşmeyi feshederek kullanıcı statüsüne son verebilir.\n
4.3 Kullanıcı,  uygulamanın kullanımına imkân veren hesaplar, kullanıcı adı ve şifre de dâhil olmak üzere tüm bilgilerin kullanım ve yönetiminden bizzat sorumludur. Kullanıcıya ait hesap, kullanıcı adı ve şifre ile gerçekleştirilen her işlem bizzat kullanıcı tarafından gerçekleştirilmiş ve bu bilgilerinin kullanıcı dışında bir kişi tarafından kullanılması, kaybolması veya el değiştirmesi nedeniyle kullanıcı ve/veya üçüncü kişilerin uğradığı zararlardan kullanıcı sorumlu olacaktır. \n
4.4 Kullanıcı, oluşturulmuş hesaplarını, kullanıcı adı ve şifresi ile üyelik profillerini hiçbir şart ve koşulda başka bir kullanıcıya devredemez veya üçüncü kişilerce kullanımına izin veremez.\n
 
 5.SF’nin Hak ve Yükümlülükleri \n
5.1 SF’nin herhangi bir sebep göstermeksizin ve herhangi bir ihbarda bulunmaksızın Gizlilik Politikası ve uygulama üzerinden yayınladığı sair koşulları dilediği zamanda tek taraflı olarak değiştirme, ilavede bulunma ve uygulamayı yeniden organize etme, konu, kapsam ve içeriğini değiştirme, yayını durdurma hakkı saklıdır. SF tarafından sözleşme, Gizlilik Koşulları ve sair koşullar üzerinde yapılan değişiklikler uygulamada yayınlandığı tarihte yürürlüğe girecek olup, uygulamanın kullanılması ile kullanıcı güncel koşulları kabul etmiş sayılacaktır. \n
5.2 Kullanıcı bilgilerini işbu Sözleşme ve Gizlilik Politikasında belirtilen kapsam dışında kullanamaz ve üçüncü kişilere açıklayamaz. SF, ayrıca kullanıcı tarafından sunulan bilgileri kullanıcı profili oluşturmak, çalışmalar yapmak ve kendi faaliyetleri ile ilgili olarak kullanma hakkına sahiptir. \n

 6. Platform ile Koşullar \n
6.1 SF, uygulama ile kullanıcılara girmiş oldukları ihtiyaçların giderileceğine dair herhangi bir taahhüt vermemekte olup, uygulama kapsamında sunulan hizmet sadece ihtiyaç sahipleri ile söz konusu ihtiyacı giderebilecek imkân ve şartlara sahip kişi ve/veya firmaların veya ihtiyacın aktif katılım ile giderilmesi sağlayacaktır.\n
6.2 Kullanıcıların profillerinde belirttikleri bilgilerin yanlış veya eksik oluşu, girilen ihtiyacın giderilememesi veya ihtiyacın kullanıcılar ile ihtiyacı karşılamak isteyen kişi/kurumlar arasında kararlaştırılan şekilde gerçekleşmemesi durumunda SF’nin hiçbir sorumluluğu bulunmayacaktır. Kullanıcı, bu kapsamdaki talep ve şikâyetlerinin muhatabının SF olmadığını, SF’nin işbu maddede yazılı nedenlerle dolayı herhangi bir sorumluluğunun bulunmadığını, bu kapsamdaki her türlü talep ve şikâyetini ilgili tarafa ileteceğini kabul, beyan ve beyan taahhüt eder. \n

 7. Sorumluluğun Sınırlandırılması  \n
7.1 SF, Site’ye girilmesi, Site’nin ya da Site’deki bilgilerin ve diğer verilerin programların kullanılması sebebiyle, Sözleşme’nin ihlali, haksız fiil, ya da başkaca sebeplere binaen, ağır kusuru dışında doğabilecek doğrudan ya da dolaylı hiçbir zarardan sorumlu değildir. SF, Sözleşme’nin ihlali, haksız fiil, ihmal veya diğer sebepler neticesinde; işlemin kesintiye uğraması, hata, ihmal, verilerin silinmesi, kaybı, işlemin veya iletişimin gecikmesi, bilgisayar virüsü, iletişim hatası, hırsızlık, imha veya izinsiz olarak kayıtlara girilmesi, kayıtların değiştirilmesi veya kullanılması hususunda herhangi bir sorumluluk kabul etmez.
\n Uygulamada link verilen sitelere girilmesi ya da uygulamanın kullanılması ile SF’nin kullanım/ziyaret sonucunda, doğabilecek her tür sorumluluktan, mahkeme ve diğer masraflar da dâhil olmak üzere her tür zarar ve talep hakkından sorumsuz kılındığı kabul edilmektedir. \n
7.2 Kullanıcı, uygulama üzerinden SF’nin kontrolünde olmayan başka internet sitelerine ve/veya platformlara, dosyalara veya içeriklere link verilebileceğini, üçüncü taraflara ait hizmetlerin sunulabileceği ve bu tür linklerin yöneldiği internet sitesini veya işleten/hizmeti veren kişiyi desteklemek amacıyla paylaşılan içeriği hakkında SF’nin herhangi bir sorumluluğu olmadığını kabul, beyan ve beyan taahhüt eder. \n
 
8. Kişisel Verilerin Korunması \n
SF, Kişisel Verilerin Korunması Kanunu kapsamında belirlenen veri işleme ve aktarım esaslarına uyacağını, kullanıcının kişisel verilerinin işlenmesini gerektiren sebeplerin ortadan kalkması halinde ilgili verileri sileceğini, yok edeceğini veya anonim hale getireceğini kabul, beyan ve taahhüt eder. Kullanıcı, kişisel verilerinin SF tarafından kullanılması, işlenmesi bakımından gerekli bilgilendirmenin kendisine yapıldığını, bu hususta yeteri kadar aydınlatıldığını kabul, beyan ve taahhüt eder. \n
 
9. Yürürlük \n
İşbu Sözleşme ve Sözleşme’nin ayrılmaz bir parçası olan Gizlilik Politikası ile Site içinde bildirilen diğer tüm Sözleşmeler Kullanıcı tarafından bu Sözleşme’nin okunup kabul edilmesi ile karşılıklı olarak kabul edilerek yürürlüğe girer. \n
 
10. Sözleşme’nin Askıya Alınması ve Feshi \n
10.1 Kullanıcının işbu sözleşmede yer alan hükümlere ve uygulamada belirtilen kural ve şartlara uymaması, kullanıcının faaliyetlerinin ya da varsa uygulamaya dâhil ettiği herhangi bir içeriğin hukuki risk oluşturması ya da üçüncü kişilerin şahsi ve ticari haklarına halel getirici ya da bu sözleşmeye aykırı mahiyette olması halinde SF, kullanıcının uygulamayı kullanımını geçici veya sürekli olarak durdurabilir. Sözleşme SF tarafından feshedilebilecektir. Kullanıcının bu nedenle SF’den herhangi bir talebi söz konusu olamaz. \n
10.2 SF dilediği zamanda Site’yi ve/veya işbu Sözleşme’yi süreli veya süresiz olarak askıya alabilecek, sona erdirebilecektir. \n""",
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