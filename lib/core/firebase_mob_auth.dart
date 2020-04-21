import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseMobAuth {
// firbase mobile auth Functions
  static FirebaseAuth auths;
  static String verificationIds;

  static Future loginUser(String phone, BuildContext context,
      Function submitProcess, Function otpNeeded) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential) async {
          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;

          if (user != null) {
            debugPrint('verification is done automatically and sucess');
            //TODO: the submit process function need to initilised
            //  submitProcess(true, true);
          } else {
            debugPrint('error');
            //submitProcess(false, true);
          }
        },
        verificationFailed: (AuthException exception) {
          debugPrint(exception.message);
          submitProcess(false, true);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          // this is where the sms are check manually
          print('Needed SMS');
          otpNeeded();
          auths = _auth;
          verificationIds = verificationId;
        },
        codeAutoRetrievalTimeout: null);
  }

  static Future<bool> smsVerification(
      String verificationId, String code, FirebaseAuth _auth) async {
    AuthResult result;
    try {
      AuthCredential credential = PhoneAuthProvider.getCredential(
          verificationId: verificationId, smsCode: code);

      result = await _auth.signInWithCredential(credential);

      print(result);
    } catch (e) {
      print(e);
      return false;
      //debugPrint('catch error');
      // submitProcess(false, false);
      // debugPrint(e);
      //return false;
    }
  }
}
