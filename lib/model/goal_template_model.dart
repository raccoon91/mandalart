import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_template_model.dart';
import 'package:mandalart/schema/goal_template_schema.dart';

class GoalTemplateModel {
  int id;
  String? name;
  Color? color;
  String? description;
  String? style;
  List<PlanTemplateModel> planTemplates;

  GoalTemplateModel({
    required this.id,
    this.name,
    this.color,
    this.description,
    this.style,
    required this.planTemplates,
  });

  factory GoalTemplateModel.fromSchema(GoalTemplate schema) {
    Color? color = schema.color != null ? Color(int.parse(schema.color!.replaceAll('#', '0xff'))) : null;
    List<PlanTemplateModel> planTemplates = schema.planTemplates.map(PlanTemplateModel.fromSchema).toList();

    return GoalTemplateModel(
      id: schema.id,
      name: schema.name,
      color: color,
      description: schema.description,
      style: schema.style,
      planTemplates: planTemplates,
    );
  }
}
