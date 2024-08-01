import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';

class DetailedPlanRepository {
  Future<List<DetailedPlanModel>?> getDetailedPlans(int? planId) async {
    try {
      if (planId == null) return null;

      final detailedPlansSchema = await IsarDB.isar.detailedPlans
          .filter()
          .planIdEqualTo(planId)
          .findAll();

      List<DetailedPlanModel> plans =
          detailedPlansSchema.map(DetailedPlanModel.fromSchema).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<DetailedPlanModel?> createDetailedPlan(
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (planId == null) return null;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      final detailedPlanSchema = DetailedPlan()
        ..planId = planId
        ..name = name
        ..color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        int planId = await IsarDB.isar.detailedPlans.put(
          detailedPlanSchema,
        );

        detailedPlanSchema.id = planId;
      });

      final detailedPlan = DetailedPlanModel.fromSchema(detailedPlanSchema);

      return detailedPlan;
    } catch (error) {
      rethrow;
    }
  }

  Future<DetailedPlanModel?> updateDetailedPlan(
    int? detailedPlanId,
    String? name,
    Color? color,
  ) async {
    try {
      if (detailedPlanId == null) return null;

      final detailedPlanSchema = await IsarDB.isar.detailedPlans
          .where()
          .idEqualTo(detailedPlanId)
          .findFirst();

      if (detailedPlanSchema == null) return null;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      detailedPlanSchema.name = name;
      detailedPlanSchema.color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        detailedPlanSchema.id = await IsarDB.isar.detailedPlans.put(
          detailedPlanSchema,
        );
      });

      final detailedPlan = DetailedPlanModel.fromSchema(detailedPlanSchema);

      return detailedPlan;
    } catch (error) {
      rethrow;
    }
  }
}