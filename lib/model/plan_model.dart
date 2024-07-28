import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_schema.dart';

class PlanModel {
  int id;
  String? name;
  Color? color;
  bool delete;

  PlanModel({
    required this.id,
    this.name,
    this.color,
    required this.delete,
  });

  factory PlanModel.fromJson(Plan schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return PlanModel(
      id: schema.id,
      name: schema.name,
      color: color,
      delete: schema.delete,
    );
  }
}
