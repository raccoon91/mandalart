import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/main.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class PlanRepository {
  Future<PlanModel?> getPlan(int? planId) async {
    try {
      if (planId == null) return null;

      final planSchema =
          await isar.plans.filter().idEqualTo(planId).findFirst();

      if (planSchema == null) return null;

      final detailedPlanSchemaList = await isar.detailedPlans
          .filter()
          .planIdEqualTo(planSchema.id)
          .findAll();

      List<DetailedPlanModel> detailedPlans =
          detailedPlanSchemaList.map(DetailedPlanModel.fromSchema).toList();

      PlanModel plan = PlanModel.fromSchema(planSchema, detailedPlans);

      return plan;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PlanModel>?> getPlans(int? projectId) async {
    try {
      if (projectId == null) return null;

      final projectSchema =
          await isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final planSchemaList =
          await isar.plans.filter().projectIdEqualTo(projectId).findAll();

      List<PlanModel> plans = [];

      for (var planSchema in planSchemaList) {
        final detailedPlanSchemaList = await isar.detailedPlans
            .filter()
            .planIdEqualTo(planSchema.id)
            .findAll();

        List<DetailedPlanModel> detailedPlans =
            detailedPlanSchemaList.map(DetailedPlanModel.fromSchema).toList();

        plans.add(PlanModel.fromSchema(planSchema, detailedPlans));
      }

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createPlan(
    int? projectId,
    String? name,
    Color? color,
  ) async {
    try {
      if (projectId == null) return;

      int? colorValue = color?.value;

      isar.writeTxnSync(() {
        final planSchema = Plan()
          ..projectId = projectId
          ..name = name
          ..color = colorValue;

        int planId = isar.plans.putSync(planSchema);

        for (int index = 0; index < 8; index++) {
          final detailedPlanSchema = DetailedPlan()
            ..projectId = projectId
            ..planId = planId;

          isar.detailedPlans.putSync(detailedPlanSchema);
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updatePlan(
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (planId == null) return;

      final planSchema = await isar.plans.where().idEqualTo(planId).findFirst();

      if (planSchema == null) return;

      int? colorValue = color?.value;

      isar.writeTxnSync(() {
        planSchema.name = name;
        planSchema.color = colorValue;

        planSchema.id = isar.plans.putSync(planSchema);
      });
    } catch (error) {
      rethrow;
    }
  }
}
