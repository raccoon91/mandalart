import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_schema.dart';

class PlanModel {
  int id;
  int visionId;
  int goalId;
  String? name;
  Color? color;
  bool isDelete;

  PlanModel({
    required this.id,
    required this.visionId,
    required this.goalId,
    this.name,
    this.color,
    required this.isDelete,
  });

  factory PlanModel.fromSchema(Plan schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return PlanModel(
      id: schema.id,
      visionId: schema.visionId,
      goalId: schema.goalId,
      name: schema.name,
      color: color,
      isDelete: schema.isDelete,
    );
  }
}
