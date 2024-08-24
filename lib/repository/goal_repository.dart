import 'package:flutter/material.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/repository/repository.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class GoalRepository extends Repository<Goal> {
  GoalRepository() : super(db: IsarDB.isar.goals);

  Future<GoalModel?> getGoal(int? goalId) async {
    try {
      if (goalId == null) return null;

      final goalSchema = await findOne((query) {
        return query.idEqualTo(goalId).isDeleteEqualTo(false);
      });

      if (goalSchema == null) return null;

      GoalModel goal = GoalModel.fromSchema(goalSchema);

      return goal;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<GoalModel>?> getGoals(int? visionId) async {
    try {
      if (visionId == null) return null;

      final goalSchemaList = await findAll((query) {
        return query.visionIdEqualTo(visionId).isDeleteEqualTo(false);
      });

      List<GoalModel> goals = goalSchemaList.map(GoalModel.fromSchema).toList();

      return goals;
    } catch (error) {
      rethrow;
    }
  }

  Future<List<Goal>?> createGoals(Vision? visionSchema) async {
    try {
      if (visionSchema == null) return null;

      List<Goal> goalSchemaList = List.generate(8, (index) {
        final goalSchema = Goal()
          ..visionId = visionSchema.id
          ..order = index;

        return goalSchema;
      });

      await IsarDB.isar.writeTxn(() async {
        await putAll(goalSchemaList);

        visionSchema.goals.addAll(goalSchemaList);

        await visionSchema.goals.save();
      });

      return goalSchemaList;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> updateGoal(int? goalId, String? name, Color? color) async {
    try {
      if (goalId == null) return false;

      final goalSchema = await findOne((query) {
        return query.idEqualTo(goalId).isDeleteEqualTo(false);
      });

      if (goalSchema == null) return false;

      int? colorValue = color?.value;

      goalSchema.name = name;
      goalSchema.color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        await putOne(goalSchema);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteAllGoal(int? visionId) async {
    try {
      if (visionId == null) return false;

      var goalSchemaList = await findAll((query) {
        return query.visionIdEqualTo(visionId);
      });

      var goalIds = goalSchemaList.map((schema) => schema.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await deleteAll(goalIds);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
