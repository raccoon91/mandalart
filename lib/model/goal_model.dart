import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/goal_schema.dart';

class GoalModel {
  int id;
  int visionId;
  String? name;
  Color? color;
  bool isDelete;
  List<PlanModel?>? plans;

  GoalModel({
    required this.id,
    required this.visionId,
    this.name,
    this.color,
    required this.isDelete,
    this.plans,
  });

  factory GoalModel.fromSchema(Goal schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;
    List<PlanModel?>? plans = schema.plans.map(PlanModel.fromSchema).toList();

    return GoalModel(
      id: schema.id,
      visionId: schema.visionId,
      name: schema.name,
      color: color,
      isDelete: schema.isDelete,
      plans: plans,
    );
  }
}
