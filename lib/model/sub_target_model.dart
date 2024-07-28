import 'package:flutter/material.dart';
import 'package:mandalart/schema/sub_target_schema.dart';

class SubTargetModel {
  int id;
  String? name;
  Color? color;
  bool delete;

  SubTargetModel({
    required this.id,
    this.name,
    this.color,
    required this.delete,
  });

  factory SubTargetModel.fromJson(SubTarget schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return SubTargetModel(
      id: schema.id,
      name: schema.name,
      color: color,
      delete: schema.delete,
    );
  }
}
