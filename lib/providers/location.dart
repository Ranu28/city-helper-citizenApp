import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MakeComplainant with ChangeNotifier {
  double? _lat;
  double? _long;

  double? get lat => _lat;
  double? get long => _long;

  void setPosition(double lat, double long) {
    _lat = lat;
    _long = long;
    notifyListeners();
  }
}
