import 'package:flutter/material.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectModel {
  int id;
  bool progress;
  String name;
  Color? color;
  bool delete;

  ProjectModel({
    required this.id,
    required this.progress,
    required this.name,
    this.color,
    required this.delete,
  });

  factory ProjectModel.fromSchema(Project schema) {
    Color? color = schema.color != null ? Color(schema.color!) : null;

    return ProjectModel(
      id: schema.id,
      progress: schema.progress,
      name: schema.name,
      color: color,
      delete: schema.delete,
    );
  }
}
