import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/schema/plan_schema.dart';

class PlanModel {
  int id;
  String? name;
  Color? color;
  bool delete;
  int projectId;
  List<DetailedPlanModel?>? detailedPlans;

  PlanModel({
    required this.id,
    this.name,
    this.color,
    required this.delete,
    required this.projectId,
    this.detailedPlans,
  });

  factory PlanModel.fromSchema(Plan schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;
    List<DetailedPlanModel?>? detailedPlans =
        schema.detailedPlans.map(DetailedPlanModel.fromSchema).toList();

    return PlanModel(
      id: schema.id,
      name: schema.name,
      color: color,
      delete: schema.delete,
      projectId: schema.projectId,
      detailedPlans: detailedPlans,
    );
  }
}
