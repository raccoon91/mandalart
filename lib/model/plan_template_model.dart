import 'package:flutter/material.dart';
import 'package:mandalart/schema/plan_template_schema.dart';

class PlanTemplateModel {
  int id;
  String? name;
  Color? color;
  String? description;
  String? style;

  PlanTemplateModel({
    required this.id,
    this.name,
    this.color,
    this.description,
    this.style,
  });

  factory PlanTemplateModel.fromSchema(PlanTemplate schema) {
    Color? color = schema.color != null ? Color(int.parse(schema.color!.replaceAll('#', '0xff'))) : null;

    return PlanTemplateModel(
      id: schema.id,
      name: schema.name,
      color: color,
      description: schema.description,
      style: schema.style,
    );
  }
}
