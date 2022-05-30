import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/main.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // AuthenticationService(this._firebaseAuth);

  Stream<User?> get authSatateChange => _firebaseAuth.authStateChanges();

  Future<void> signIn(
      {String? email, String? password, BuildContext? context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      print("sign in");
    } on FirebaseAuthException catch (e) {
      print(e.message!);
    }
  }

  Future<void> signUP(
      {String? email, String? password, BuildContext? context}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      print("sign up");

      String userId = _firebaseAuth.currentUser!.uid;

      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'id': userId,
        'isAuth': false,
        'role': 'citizen',
        'profilePicture':
            'https://firebasestorage.googleapis.com/v0/b/complaint-management-app-8a7f8.appspot.com/o/userProfilePlaceholder%2Fistockphoto-1016744076-612x612.jpg?alt=media&token=22b3beba-7ac7-41e1-aeff-e536ccfb0072'
      });
      // 'name': '',
      //   'birthday' : '',
      //   'street_no' : '',
      //   'street_name_01' : '',
      //   'street_name_02': '',
      //   'district':'',
      //   'province':'',
      //   'latitude' :'',
      //   'longitude':'',
      //   'postal code': '',

      _firebaseAuth.signOut();

      Navigator.pop(context!);
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context!,
        builder: (context) => Center(
          child: Text(e.message!),
        ),
      );
    }
  }

  Future<String> checkUser(String uid) async {
    final userDeatails =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    Map<String, dynamic> data = userDeatails.data() as Map<String, dynamic>;
    final rr = data['role'];
    return rr;
  }
}
