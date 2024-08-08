import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class PlanRepository {
  Future<PlanModel?> getPlan(int? planId) async {
    try {
      if (planId == null) return null;

      final planSchema =
          await IsarDB.isar.plans.filter().idEqualTo(planId).findFirst();

      if (planSchema == null) return null;

      PlanModel plan = PlanModel.fromSchema(planSchema);

      return plan;
    } catch (error) {
      rethrow;
    }
  }

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

      List<PlanModel> plans = plansSchema.map(PlanModel.fromSchema).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlanModel?> createPlan(
    int? projectId,
    String? name,
    Color? color,
  ) async {
    try {
      if (projectId == null) return null;

      int? colorValue = color?.value;

      final planSchema = Plan()
        ..projectId = projectId
        ..name = name
        ..color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        int planId = await IsarDB.isar.plans.put(
          planSchema,
        );

        planSchema.id = planId;

        for (int index = 0; index < 8; index++) {
          final detailedPlanSchema = DetailedPlan()..planId = planId;

          planSchema.detailedPlans.add(detailedPlanSchema);

          await IsarDB.isar.detailedPlans.put(
            detailedPlanSchema,
          );
        }

        await planSchema.detailedPlans.save();
      });

      final plan = PlanModel.fromSchema(planSchema);

      return plan;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlanModel?> updatePlan(
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (planId == null) return null;

      final planSchema =
          await IsarDB.isar.plans.where().idEqualTo(planId).findFirst();

      if (planSchema == null) return null;

      int? colorValue = color?.value;

      planSchema.name = name;
      planSchema.color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        planSchema.id = await IsarDB.isar.plans.put(
          planSchema,
        );
      });

      final plan = PlanModel.fromSchema(planSchema);

      return plan;
    } catch (error) {
      rethrow;
    }
  }
}
