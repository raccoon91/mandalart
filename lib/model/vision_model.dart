import 'package:flutter/material.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/schema/vision_schema.dart';

class VisionModel {
  int id;
  bool inProgress;
  String name;
  Color? color;
  bool isDelete;
  List<GoalModel?>? goals;

  VisionModel({
    required this.id,
    required this.inProgress,
    required this.name,
    this.color,
    required this.isDelete,
    this.goals,
  });

  factory VisionModel.fromSchema(Vision schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;
    List<GoalModel?>? goals = schema.goals.map(GoalModel.fromSchema).toList();

    return VisionModel(
      id: schema.id,
      inProgress: schema.inProgress,
      name: schema.name,
      color: color,
      isDelete: schema.isDelete,
      goals: goals,
    );
  }
}
