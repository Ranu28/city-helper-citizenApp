// To parse this JSON data, do
//
//     final cities = citiesFromJson(jsonString);

import 'dart:convert';

List<Cities> citiesFromJson(String str) =>
    List<Cities>.from(json.decode(str).map((x) => Cities.fromJson(x)));

String citiesToJson(List<Cities> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cities {
  Cities({
    required this.id,
    required this.districtId,
    required this.nameEn,
    this.nameSi,
    this.nameTa,
    this.subNameEn,
    this.subNameSi,
    this.subNameTa,
    this.postcode,
    this.latitude,
    this.longitude,
  });

  String id;
  int districtId;
  String nameEn;
  String? nameSi;
  String? nameTa;
  String? subNameEn;
  String? subNameSi;
  String? subNameTa;
  String? postcode;
  String? latitude;
  String? longitude;

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
        id: json["_id"],
        districtId: json["district_id"],
        nameEn: json["name_en"],
        nameSi: json["name_si"],
        nameTa: json["name_ta"],
        subNameEn: json["sub_name_en"],
        subNameSi: json["sub_name_si"],
        subNameTa: json["sub_name_ta"],
        postcode: json["postcode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "district_id": districtId,
        "name_en": nameEn,
        "name_si": nameSi,
        "name_ta": nameTa,
        "sub_name_en": subNameEn,
        "sub_name_si": subNameSi,
        "sub_name_ta": subNameTa,
        "postcode": postcode,
        "latitude": latitude,
        "longitude": longitude,
      };
}
