import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class PlanRepository extends Repository<Plan> {
  PlanRepository() : super(db: IsarDB.isar.plans);

  Future<PlanModel?> getPlan({int? planId}) async {
    try {
      if (planId == null) return null;

      final planSchema = await findOne(builder: (query) {
        return query.idEqualTo(planId);
      });

      if (planSchema == null) return null;

      PlanModel plans = PlanModel.fromSchema(planSchema);

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<Plan?> getPlanSchema({int? planId}) async {
    try {
      if (planId == null) return null;

      final planSchema = await findOne(builder: (query) {
        return query.idEqualTo(planId);
      });

      return planSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PlanModel>?> getPlans({int? goalId}) async {
    try {
      if (goalId == null) return null;

      final planSchemaList = await findAll(builder: (query) {
        return query.goalIdEqualTo(goalId);
      });

      List<PlanModel> plans = planSchemaList.map(PlanModel.fromSchema).toList();

      return plans;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Plan>?> createPlans({Vision? visionSchema, List<Goal>? goalSchemaList}) async {
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

          await putAll(schemaList: planSchemaList);

          goalSchema.plans.addAll(planSchemaList);

          await goalSchema.plans.save();
        }
      });

      return schemaList;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updatePlan({int? planId, PlanTemplate? planTemplate}) async {
    try {
      if (planId == null) return false;

      final planSchema = await findOne(builder: (query) {
        return query.idEqualTo(planId);
      });

      if (planSchema == null) return false;

      planSchema.planTemplate.value = planTemplate;

      await IsarDB.isar.writeTxn(() async {
        await planSchema.planTemplate.save();
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> removePlan({int? planId}) async {
    try {
      if (planId == null) return false;

      final planSchema = await findOne(builder: (query) {
        return query.idEqualTo(planId);
      });

      if (planSchema == null) return false;

      await IsarDB.isar.writeTxn(() async {
        await planSchema.planTemplate.reset();
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllPlan({int? visionId}) async {
    try {
      if (visionId == null) return false;

      var planSchemaList = await findAll(builder: (query) {
        return query.visionIdEqualTo(visionId);
      });

      var planIds = planSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(ids: planIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
