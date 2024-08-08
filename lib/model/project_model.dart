import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectModel {
  int id;
  bool progress;
  String name;
  Color? color;
  bool delete;
  List<PlanModel?>? plans;

  ProjectModel({
    required this.id,
    required this.progress,
    required this.name,
    this.color,
    required this.delete,
    this.plans,
  });

  factory ProjectModel.fromSchema(Project schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;
    List<PlanModel?>? plans = schema.plans.map(PlanModel.fromSchema).toList();

    return ProjectModel(
      id: schema.id,
      progress: schema.progress,
      name: schema.name,
      color: color,
      delete: schema.delete,
      plans: plans,
    );
  }
}
