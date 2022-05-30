import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

UploadTask? uploadTask;
String urlDownload = "";
final user = FirebaseAuth.instance.currentUser!;

class SubmitComplain {
  Future<String?> submitAComplain(
      String title,
      String description,
      String district,
      double longitudes,
      double latitude,
      File? filee,
      office) async {
    try {
      if (filee != null) {
        // await FirebaseStorage.instance
        //     .ref('flutter pub add firebase_storage/${"waterboard"}/${filee}')
        //     .putFile(filee);

        final path = 'complaints_images/${office}/${filee}';
        final file = File(filee.path);
        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);

        final snapShot = await uploadTask!.whenComplete(() => {});

        urlDownload = await snapShot.ref.getDownloadURL();
        debugPrint(urlDownload);
      }

      // var cmp = await FirebaseFirestore.instance
      //     .collection(office) //department
      //     .doc("district_office") //district_office
      //     .collection(district)
      //     .doc("complaints")
      //     .collection('complaints_of_districts')
      //     .add({
      //   'title': title,
      //   'description': description,
      //   'time': DateTime.now(),
      //   "longitudes": longitudes,
      //   "latitude": latitude,
      //   "document": urlDownload,
      //   "userID": user.uid,
      // });

      var cmp = await FirebaseFirestore.instance
          .collection("complaints") //department
          .doc(office) //district_office
          .collection("complaints")
          .doc(district)
          .collection("district_complaint")
          .add({
        'title': title,
        'description': description,
        'time': DateTime.now(),
        "longitudes": longitudes,
        "latitude": latitude,
        "document": urlDownload,
        "userID": user.uid,
        "district": district
      });
      return "Success";
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
