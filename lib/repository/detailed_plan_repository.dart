import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/main.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';

class DetailedPlanRepository {
  Future<List<DetailedPlanModel>?> getDetailedPlans(int? planId) async {
    try {
      if (planId == null) return null;

      final detailedPlansSchema =
          await isar.detailedPlans.filter().planIdEqualTo(planId).findAll();

      List<DetailedPlanModel> detailedPlans =
          detailedPlansSchema.map(DetailedPlanModel.fromSchema).toList();

      return detailedPlans;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createDetailedPlan(
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (planId == null) return;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      isar.writeTxnSync(() {
        final detailedPlanSchema = DetailedPlan()
          ..planId = planId
          ..name = name
          ..color = colorValue;

        isar.detailedPlans.putSync(detailedPlanSchema);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updateDetailedPlan(
    int? detailedPlanId,
    String? name,
    Color? color,
  ) async {
    try {
      if (detailedPlanId == null) return false;

      final detailedPlanSchema = await isar.detailedPlans
          .where()
          .idEqualTo(detailedPlanId)
          .findFirst();

      if (detailedPlanSchema == null) return false;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      isar.writeTxnSync(() {
        detailedPlanSchema.name = name;
        detailedPlanSchema.color = colorValue;

        detailedPlanSchema.id = isar.detailedPlans.putSync(detailedPlanSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
