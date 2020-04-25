import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuth with ChangeNotifier {
  final Firestore db = Firestore.instance;

// to chech acc is exist in firestore
  Future<bool> accChecker(String docId) async {
    try {
      final fetchData = await db.collection('admins').document(docId).get();
      print(fetchData.exists);
      if (!fetchData.exists) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // to add acc on firestore
  Future<void> addAcc(Map _data, String _docId) async {
    try {
      await db.collection('admins').document(_docId).setData({
        'name': _data['name'],
        'gmail': _data['gmail'],
        'academic': _data['academic']
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
