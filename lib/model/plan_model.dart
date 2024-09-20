import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';

class PlanModel {
  int id;
  int visionId;
  int goalId;
  String? name;
  Color? color;
  PlanTemplate? planTemplate;

  PlanModel({
    required this.id,
    required this.visionId,
    required this.goalId,
    this.name,
    this.color,
    this.planTemplate,
  });

  factory PlanModel.fromSchema(Plan schema) {
    PlanTemplate? planTemplate = schema.planTemplate.value;
    Color? color = planTemplate?.color != null ? Color(int.parse(planTemplate!.color!.replaceAll('#', '0xff'))) : null;

    return PlanModel(
      id: schema.id,
      visionId: schema.visionId,
      goalId: schema.goalId,
      name: planTemplate?.name,
      color: color,
      planTemplate: planTemplate,
    );
  }
}
