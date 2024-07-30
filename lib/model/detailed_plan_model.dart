import 'package:flutter/material.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';

class DetailedPlanModel {
  int id;
  String? name;
  Color? color;
  bool delete;
  int planId;

  DetailedPlanModel({
    required this.id,
    this.name,
    this.color,
    required this.delete,
    required this.planId,
  });

  factory DetailedPlanModel.fromSchema(DetailedPlan schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return DetailedPlanModel(
      id: schema.id,
      name: schema.name,
      color: color,
      delete: schema.delete,
      planId: schema.planId,
    );
  }
}
