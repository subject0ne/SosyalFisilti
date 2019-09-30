import 'package:fisilti_arayuz/arayuz/anasayfa.dart';
import 'package:fisilti_arayuz/arayuz/giris.dart';
import 'package:fisilti_arayuz/arayuz/info.dart';
import 'package:flutter/material.dart';
import 'arayuz/fotograflar.dart';
import 'arayuz/profil.dart';
//sayfa geçişleri
void main() => runApp(MaterialApp(
 debugShowCheckedModeBanner: false,
 initialRoute: "/",  //initialroute ilk rotam = /
 routes: {
   "/": (context) => Splash(),      //ilk girisEkrani ile açılır
   "ikincisayfa": (context) => Info(),//geçiş ekranı
   "ucuncusayfa": (context) => HomePage(),//anasayfa
   "dorduncusayfa": (context) => ProfileGecis(),//profil sayfası
   "besincisayfa": (context) => FotografAlani("Fotoğraflar"),//fotoğraf sayfası
 },
));

