import 'package:flutter/material.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class PlanRepository extends Repository<Plan> {
  PlanRepository() : super(db: IsarDB.isar.plans);

  Future<PlanModel?> getPlan(int? planId) async {
    try {
      if (planId == null) return null;

      final planSchema = await findOne((query) {
        return query.idEqualTo(planId).isDeleteEqualTo(false);
      });

      if (planSchema == null) return null;

      PlanModel plans = PlanModel.fromSchema(planSchema);

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<Plan?> getPlanSchema(int? planId) async {
    try {
      if (planId == null) return null;

      final planSchema = await findOne((query) {
        return query.idEqualTo(planId).isDeleteEqualTo(false);
      });

      return planSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PlanModel>?> getPlans(int? goalId) async {
    try {
      if (goalId == null) return null;

      final planSchemaList = await findAll((query) {
        return query.goalIdEqualTo(goalId).isDeleteEqualTo(false);
      });

      List<PlanModel> plans = planSchemaList.map(PlanModel.fromSchema).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Plan>?> createPlans(
    Vision? visionSchema,
    List<Goal>? goalSchemaList,
  ) async {
    try {
      if (visionSchema == null || goalSchemaList == null) return null;

      List<Plan> schemaList = [];

      await IsarDB.isar.writeTxn(() async {
        for (var goalSchema in goalSchemaList) {
          var planSchemaList = List.generate(8, (index) {
            final planSchema = Plan()
              ..visionId = visionSchema.id
              ..goalId = goalSchema.id
              ..order = index;

            return planSchema;
          });

          schemaList += planSchemaList;

          await putAll(planSchemaList);

          goalSchema.plans.addAll(planSchemaList);

          await goalSchema.plans.save();
        }
      });

      return schemaList;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updatePlan(int? planId, String? name, Color? color) async {
    try {
      if (planId == null) return false;

      final planSchema = await findOne((query) {
        return query.idEqualTo(planId).isDeleteEqualTo(false);
      });

      if (planSchema == null) return false;

      int? colorValue = color?.value;

      planSchema.name = name;
      planSchema.color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        await putOne(planSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllPlan(int? visionId) async {
    try {
      if (visionId == null) return false;

      var planSchemaList = await findAll((query) {
        return query.visionIdEqualTo(visionId);
      });

      var planIds = planSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(planIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
