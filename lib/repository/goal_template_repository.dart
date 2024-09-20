import 'package:flutter/material.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/goal_template_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/goal_template_schema.dart';

class GoalTemplateRepository extends Repository<GoalTemplate> {
  GoalTemplateRepository() : super(db: IsarDB.isar.goalTemplates);

  Future<GoalTemplate?> getGoalTemplate({int? goalTemplateId}) async {
    try {
      if (goalTemplateId == null) return null;

      final goalTemplateSchema = await findOne(builder: (query) {
        return query.idEqualTo(goalTemplateId);
      });

      return goalTemplateSchema;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<GoalTemplateModel>> getGoalTemplates() async {
    try {
      final goalTemplateSchemaList = await findAll();

      List<GoalTemplateModel> goalTemplates = goalTemplateSchemaList.map(GoalTemplateModel.fromSchema).toList();

      return goalTemplates;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createGoalTemplate({required String name, Color? color}) async {
    try {
      final goalTemplateSchema = GoalTemplate()
        ..name = name
        ..color = color == null ? null : '#${color.value.toRadixString(16)}';

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: goalTemplateSchema);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateGoalTemplate({required int goalTemplateId, required String name, Color? color}) async {
    try {
      final goalTemplateSchema = await findOne(builder: (query) {
        return query.idEqualTo(goalTemplateId);
      });

      if (goalTemplateSchema == null) return;

      goalTemplateSchema.name = name;
      goalTemplateSchema.color = color == null ? null : '#${color.value.toRadixString(16)}';

      await IsarDB.isar.writeTxn(() async {
        await putOne(schema: goalTemplateSchema);
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllGoalTemplate() async {
    try {
      var goalTemplateSchemaList = await findAll();

      var goalTemplateIds = goalTemplateSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(ids: goalTemplateIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
