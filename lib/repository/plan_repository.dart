import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/schema/plan_schema.dart';

class PlanRepository {
  static Future<int> getSize() async {
    try {
      final size = await IsarDB.isar.plans.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<PlanModel?> get(int? planId) async {
    try {
      if (planId == null) return null;

      final planSchema = await IsarDB.isar.plans
          .filter()
          .idEqualTo(planId)
          .isDeleteEqualTo(false)
          .findFirst();

      if (planSchema == null) return null;

      PlanModel plans = PlanModel.fromSchema(planSchema);

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<PlanModel>?> gets(int? goalId) async {
    try {
      if (goalId == null) return null;

      final planSchemaList = await IsarDB.isar.plans
          .filter()
          .goalIdEqualTo(goalId)
          .isDeleteEqualTo(false)
          .findAll();

      List<PlanModel> plans = planSchemaList.map(PlanModel.fromSchema).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  static Future<PlanModel?> update(
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (planId == null) return null;

      final planSchema = await IsarDB.isar.plans
          .filter()
          .idEqualTo(planId)
          .isDeleteEqualTo(false)
          .findFirst();

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
