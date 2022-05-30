import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  String? firstName;
  String? lastName;
  String? nic;
  String? mobileNumber;

  String? streetNo;
  String? streetName1;
  String? streetName2;
  String? city;
  String? province;
  String? district;
  String? postalCode;

  int activeIndex = 0;
  int totalIndex = 0;
}
