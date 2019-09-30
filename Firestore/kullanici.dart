import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fisilti_arayuz/modelsVT/vt_uye.dart';

class KullaniciIslemleri {
  final Firestore _firestore = Firestore.instance;

  void kullaniciEkle() {
    _firestore
        .collection("users")
        .document("paylasım")
        .setData({'ad': 'oguz'}).then((v) => debugPrint('oldu bu defa'));
  }
}
