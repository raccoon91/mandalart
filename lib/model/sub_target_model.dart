import 'package:flutter/material.dart';
import 'package:mandalart/schema/sub_target_schema.dart';

class SubTargetModel {
  int id;
  String? name;
  Color? color;

  SubTargetModel({
    required this.id,
    this.name,
    required this.color,
  });

  factory SubTargetModel.fromJson(SubTarget schema) {
    return SubTargetModel(
      id: schema.id,
      name: schema.name,
      color: schema.color != null ? Color(schema.color!) : null,
    );
  }
}
