import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/goal_template_schema.dart';

class GoalModel {
  int id;
  int visionId;
  String? name;
  Color? color;
  GoalTemplate? goalTemplate;
  List<PlanModel?>? plans;

  GoalModel({
    required this.id,
    required this.visionId,
    this.name,
    this.color,
    this.goalTemplate,
    this.plans,
  });

  factory GoalModel.fromSchema(Goal schema) {
    GoalTemplate? goalTemplate = schema.goalTemplate.value;
    Color? color = goalTemplate?.color != null ? Color(int.parse(goalTemplate!.color!.replaceAll('#', '0xff'))) : null;
    List<PlanModel?>? plans = schema.plans.map(PlanModel.fromSchema).toList();

    return GoalModel(
      id: schema.id,
      visionId: schema.visionId,
      name: goalTemplate?.name,
      color: color,
      goalTemplate: goalTemplate,
      plans: plans,
    );
  }
}
