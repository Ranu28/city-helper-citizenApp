// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<News> newsFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

String newsToJson(List<News> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class News {
  News({
    this.department,
    this.description,
    this.time,
    this.title,
  });

  String? department;
  String? description;
  Timestamp? time;
  String? title;

  factory News.fromJson(Map<String, dynamic> json) => News(
        department: json["department"],
        description: json["description"],
        time: json["time"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "description": description,
        "time": time,
        "title": title,
      };
}
