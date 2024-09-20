import 'package:flutter/material.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/plan_template_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/goal_template_schema.dart';
import 'package:mandalart/schema/plan_template_schema.dart';

class PlanTemplateRepository extends Repository<PlanTemplate> {
  PlanTemplateRepository() : super(db: IsarDB.isar.planTemplates);

  Future<PlanTemplate?> getPlanTemplate({int? planTemplateId}) async {
    try {
      if (planTemplateId == null) return null;

      final planTemplateSchema = await findOne(builder: (query) {
        return query.idEqualTo(planTemplateId);
      });

      return planTemplateSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<PlanTemplateModel>> getPlanTemplates() async {
    try {
      final planTemplateSchemaList = await findAll();

      List<PlanTemplateModel> planTemplates = planTemplateSchemaList.map(PlanTemplateModel.fromSchema).toList();

      return planTemplates;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createPlanTemplate({GoalTemplate? goalTemplate, required String name, Color? color}) async {
    try {
      if (goalTemplate == null) return;

      final planTemplateSchema = PlanTemplate()
        ..name = name
        ..color = color == null ? null : '#${color.value.toRadixString(16)}';

      goalTemplate.planTemplates.add(planTemplateSchema);

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: planTemplateSchema);
        await goalTemplate.planTemplates.save();
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updatePlanTemplate({required int planTemplateId, required String name, Color? color}) async {
    try {
      final planTemplateSchema = await findOne(builder: (query) {
        return query.idEqualTo(planTemplateId);
      });

      if (planTemplateSchema == null) return;

      planTemplateSchema.name = name;
      planTemplateSchema.color = color == null ? null : '#${color.value.toRadixString(16)}';

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: planTemplateSchema);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllPlanTemplate() async {
    try {
      var planTemplateSchemaList = await findAll();

      var planTemplateIds = planTemplateSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(ids: planTemplateIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
