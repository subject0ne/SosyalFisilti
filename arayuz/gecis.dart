import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'anasayfa.dart';
import 'package:fisilti_arayuz/services/authentication.dart';
import 'package:fisilti_arayuz/pages/root_page.dart';

class IntroScreen extends StatefulWidget {
  @override
  IntroScreenState createState() => IntroScreenState();
}
class IntroScreenState extends State<IntroScreen> {
   List<Slide> slides = new List();
    @override
  void initState() {
    super.initState();

    slides.add(   //geçiş slaytları oluştur
      new Slide(
        title: "YARDIMLAŞMA \n AĞI",
        styleTitle: TextStyle(
            color: Colors.purple,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Bu uygulama ile çok küçük dokunuşlarla \n bir çok hayata büyük dokunuşlar gerçekleştirebilirsiniz .",
        styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/giris2.jpg",
        backgroundColor: Color(0xFFF3E5F5),
      ),
    );
    slides.add(
      new Slide(
       //backgroundColor: Color(0xFFBA68C8),
        title: "PAYLAŞTIKÇA GÜLEN YÜZLER",
        styleTitle: TextStyle(
            color: Colors.purple,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Uygulama sosyal yardımlaşma amacı ile oluşturulmuş \n kullanıcıların aktif olarak destek/ihtiyaç  \n ekleyebileceği platformdur.",
        styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/el.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "ÜYE OL",
        styleTitle: TextStyle(
            color: Colors.purple,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Herkes için paylaş .",
        styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'),
        pathImage: "assets/images/3.jpeg",
        backgroundColor: Color(0xff9932CC),
      ),
    );
  }
 void onDonePress() {
    
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xffffcc5c),//done buton kendi rengi>
      size: 35.0,
    );
  }

  Widget renderDoneBtn() => IconButton(icon: Icon(Icons.done),color: Color(0xFFFFFFFF),
   onPressed:() { Navigator.push(
      context, MaterialPageRoute(builder: (context) => new RootPage(auth: new Auth())),);});

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xffffcc5c), //skipbuton kendi rengi
    );
  }

List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                //onTap: () =>Navigator.push(context, "/uyeOl"), //Sayfada herhangi bir alana tıklanırsa eğer ÜYE OL alanına atar
                child: Image.asset(     //Resim alanının genişliği yüksekliği 
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(    //text alan özellikleri
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;

  }
   
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: new IntroSlider(
      //list slides
      slides: this.slides,

      //skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0xFFCE93D8), //skip butonu elips içi rengi
      highlightColorSkipBtn: Color(0xffffcc5c),

      //next button
      renderNextBtn: this.renderNextBtn(),

      //done button
      renderDoneBtn: this.renderDoneBtn(
      ),
      
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0xFFCE93D8),  //elips olan ok done buton dışı
      highlightColorDoneBtn: Color(0xFFCE93D8), ///OK Done butone

      //dot indicator
      colorDot: Color(0xFFCE93D8), //orta geçişlerin ana rengi -mor-
      colorActiveDot: Color(0xffffcc5c), 
      sizeDot: 13.0,

      //list custom tabs
      listCustomTabs: this.renderListCustomTabs(),

      //show or hide status bar
      shouldHideStatusBar: true,
    ),
    );
  }
}

 