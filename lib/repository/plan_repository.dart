import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class PlanRepository {
  Future<List<PlanModel>?> getPlans(int? projectId) async {
    try {
      if (projectId == null) return null;

      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final plansSchema = await IsarDB.isar.plans
          .filter()
          .projectIdEqualTo(projectId)
          .findAll();

      List<PlanModel> plans = plansSchema.map(PlanModel.fromJson).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlanModel?> createPlan(
    int? projectId,
    String name,
    Color color,
  ) async {
    try {
      if (projectId == null) return null;

      final projectSchema =
          await IsarDB.isar.projects.where().idEqualTo(projectId).findFirst();

      if (projectSchema == null) return null;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      final planSchema = Plan()
        ..name = name
        ..color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        planSchema.id = await IsarDB.isar.plans.put(
          planSchema,
        );
      });

      final plan = PlanModel.fromJson(planSchema);

      return plan;
    } catch (error) {
      rethrow;
    }
  }
}
