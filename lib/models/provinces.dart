// To parse this JSON data, do
//
//     final Provinces = ProvincesFromJson(jsonString);

import 'dart:convert';

List<Provinces> ProvincesFromJson(String str) =>
    List<Provinces>.from(json.decode(str).map((x) => Provinces.fromJson(x)));

String ProvincesToJson(List<Provinces> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Provinces {
  Provinces({
    required this.id,
    required this.provinceId,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });

  String id;
  int provinceId;
  String nameEn;
  String nameSi;
  String nameTa;

  factory Provinces.fromJson(Map<String, dynamic> json) => Provinces(
        id: json["_id"],
        provinceId: json["id"],
        nameEn: json["name_en"],
        nameSi: json["name_si"],
        nameTa: json["name_ta"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": provinceId,
        "name_en": nameEn,
        "name_si": nameSi,
        "name_ta": nameTa,
      };
}
