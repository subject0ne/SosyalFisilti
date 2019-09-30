import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMedthods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      Firestore.instance.collection('users').add(carData).catchError((e) {
        print(e);
      });
      
    } else {
      print('');
    }
  }

  getData() async {
    return await Firestore.instance.collection('users').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('users')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('users')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  aramaYap() {}
}
