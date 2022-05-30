// To parse this JSON data, do
//
//     final districts = districtsFromJson(jsonString);

import 'dart:convert';

List<Districts> districtsFromJson(String str) =>
    List<Districts>.from(json.decode(str).map((x) => Districts.fromJson(x)));

String districtsToJson(List<Districts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Districts {
  Districts({
    required this.id,
    required this.districtId,
    required this.provinceId,
    required this.nameEn,
    required this.nameSi,
    required this.nameTa,
  });

  String id;
  int districtId;
  int provinceId;
  String nameEn;
  String nameSi;
  String nameTa;

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        id: json["_id"],
        districtId: json["id"],
        provinceId: json["province_id"],
        nameEn: json["name_en"],
        nameSi: json["name_si"],
        nameTa: json["name_ta"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id": districtId,
        "province_id": provinceId,
        "name_en": nameEn,
        "name_si": nameSi,
        "name_ta": nameTa,
      };
}
