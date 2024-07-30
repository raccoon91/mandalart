import 'package:flutter/material.dart';

class MandalModel {
  int? id;
  String? name;
  Color? color;

  MandalModel({
    this.id,
    this.name,
    this.color,
  });

  factory MandalModel.fromSchema(dynamic schema) {
    return MandalModel(
      id: schema.id,
      name: schema.name,
      color: schema.color,
    );
  }

  factory MandalModel.fromJson(Map<String, dynamic> json) {
    return MandalModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}
