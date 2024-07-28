import 'package:flutter/material.dart';

class MandalModel {
  int? id;
  String type;
  String? name;
  Color? color;

  MandalModel({
    this.id,
    required this.type,
    this.name,
    this.color,
  });

  factory MandalModel.fromJson(String type, dynamic json) {
    return MandalModel(
      id: json.id,
      type: type,
      name: json.name,
      color: json.color,
    );
  }
}
