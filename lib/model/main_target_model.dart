import 'package:flutter/material.dart';
import 'package:mandalart/schema/main_target_schema.dart';

class MainTargetModel {
  int id;
  String? name;
  Color? color;
  bool delete;

  MainTargetModel({
    required this.id,
    this.name,
    this.color,
    required this.delete,
  });

  factory MainTargetModel.fromJson(MainTarget schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return MainTargetModel(
      id: schema.id,
      name: schema.name,
      color: color,
      delete: schema.delete,
    );
  }
}
