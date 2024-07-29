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

  factory MandalModel.fromSchema(String type, dynamic schema) {
    return MandalModel(
      id: schema.id,
      type: type,
      name: schema.name,
      color: schema.color,
    );
  }

  factory MandalModel.fromJson(String type, Map<String, dynamic> json) {
    return MandalModel(
      id: json['id'],
      type: type,
      name: json['name'],
      color: json['color'],
    );
  }
}
