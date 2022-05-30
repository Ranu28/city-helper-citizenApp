import 'dart:convert';

import 'package:flutter_login_ui/models/cities.dart';
import 'package:flutter_login_ui/models/districts.dart';
import 'package:flutter_login_ui/models/provinces.dart';
import 'package:http/http.dart' as http;

class ApiForCities {
  // getting list of provinces
  Future<List<Provinces>?> getProvince() async {
    var reqest = "https://locatesrilanka.herokuapp.com/provinces";

    var client = http.Client();
    var uri = Uri.parse(reqest);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      // print(response.body);
      return ProvincesFromJson(response.body);
    }
  }

  // getting list of Districts
  Future<List<Districts>?> getDistricts() async {
    var reqest = "https://locatesrilanka.herokuapp.com/districts";

    var client = http.Client();
    var uri = Uri.parse(reqest);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      // print(response.body);
      return districtsFromJson(response.body);
    }
  }

  // getting list of cities
  Future<List<Cities>?> getCities() async {
    var reqest = "https://locatesrilanka.herokuapp.com/cities";

    var client = http.Client();
    var uri = Uri.parse(reqest);
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      // print(response.body);
      return citiesFromJson(response.body);
    }
  }
}
