import 'package:flutter/material.dart';
import 'package:mandalart/model/sub_target_model.dart';
import 'package:mandalart/schema/main_target_schema.dart';

class MainTargetModel {
  int id;
  String? name;
  Color? color;
  List<SubTargetModel>? subTargets;

  MainTargetModel({
    required this.id,
    this.name,
    required this.color,
    this.subTargets,
  });

  factory MainTargetModel.fromJson(MainTarget schema) {
    var subTargets = schema.subTargets.map(SubTargetModel.fromJson).toList();

    return MainTargetModel(
      id: schema.id,
      name: schema.name,
      color: schema.color != null ? Color(schema.color!) : null,
      subTargets: subTargets,
    );
  }
}
