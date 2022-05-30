import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/screens/auth/enterDetails/enter_details.dart';
import 'package:flutter_login_ui/screens/dashboad/dashboard.dart';

class CheckUserData {
  Future<void> checkUserDetails({
    required String userId,
    BuildContext? context,
  }) async {
    try {
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(userId).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var value = data?['isAuth'];
        if (value == true) {
          Navigator.pushReplacement(
              context!,
              MaterialPageRoute(
                builder: (context) => EnterYourDetails(),
              ));
        }
        // else
        //   Navigator.pushReplacement(
        //       context!,
        //       MaterialPageRoute(
        //         builder: (context) => DashboardUser(),
        //       ));
      }
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
