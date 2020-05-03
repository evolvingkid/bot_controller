import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuth with ChangeNotifier {
  final Firestore db = Firestore.instance;
  Map userData;

  Future<void> accSaver() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String parsedJson = json.encode({
      'gmail': userData['gmail'],
      'academic': userData['academic'],
      'name': userData['name'],
      'mobNumber': userData['mobNumber']
    });
    bool _isComplete = await preferences.setString('userData', parsedJson);
    notifyListeners();
  }

  Future<bool> accVerification(String _docId) async {
    try {
      final fetchdata = await db.collection('admins').document(_docId).get();

      if (fetchdata.exists) {
        if (fetchdata.data.containsKey('admin')) {
          userData = {
            'gmail': fetchdata.data['gmail'],
            'academic': fetchdata.data['academic'],
            'name': fetchdata.data['name'],
            'mobNumber': _docId
          };
          await accSaver();
          return true;
        }
        return false;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

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

  Future<void> autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      if (preferences.containsKey('userData')) {
        String fetchData = preferences.getString('userData');
        Map _decodeVal = json.decode(fetchData);
        userData = {
          'gmail': _decodeVal['gmail'],
          'academic': _decodeVal['academic'],
          'name': _decodeVal['name'],
          'mobNumber': _decodeVal['mobNumber']
        };
        notifyListeners();
      }
    } catch (e) {}
  }
}
