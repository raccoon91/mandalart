import 'package:flutter/material.dart';
import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectModel {
  int id;
  String name;
  Color? color;
  bool isDefault;
  List<MainTargetModel> mainTargets;

  ProjectModel({
    required this.id,
    required this.name,
    this.color,
    required this.isDefault,
    required this.mainTargets,
  });

  factory ProjectModel.fromJson(Project schema) {
    var mainTargets = schema.mainTargets.map(MainTargetModel.fromJson).toList();

    return ProjectModel(
      id: schema.id,
      name: schema.name,
      color: schema.color != null ? Color(schema.color!) : null,
      isDefault: schema.isDefault,
      mainTargets: mainTargets,
    );
  }
}
