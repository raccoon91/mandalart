import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class GoalRepository {
  static Future<int> getSize() async {
    try {
      final size = await IsarDB.isar.goals.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<GoalModel?> get(int? goalId) async {
    try {
      if (goalId == null) return null;

      final goalSchema = await IsarDB.isar.goals
          .filter()
          .idEqualTo(goalId)
          .isDeleteEqualTo(false)
          .findFirst();

      if (goalSchema == null) return null;

      GoalModel goal = GoalModel.fromSchema(goalSchema);

      return goal;
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<GoalModel>?> gets() async {
    try {
      final visionSchema = await IsarDB.isar.visions
          .filter()
          .inProgressEqualTo(true)
          .isDeleteEqualTo(false)
          .findFirst();

      if (visionSchema == null) return null;

      var visionId = visionSchema.id;

      final goalSchemaList = await IsarDB.isar.goals
          .filter()
          .visionIdEqualTo(visionId)
          .isDeleteEqualTo(false)
          .findAll();

      List<GoalModel> goals = goalSchemaList.map(GoalModel.fromSchema).toList();

      return goals;
    } catch (error) {
      rethrow;
    }
  }

  static Future<GoalModel?> update(
    int? goalId,
    String? name,
    Color? color,
  ) async {
    try {
      if (goalId == null) return null;

      final goalSchema = await IsarDB.isar.goals
          .filter()
          .idEqualTo(goalId)
          .isDeleteEqualTo(false)
          .findFirst();

      if (goalSchema == null) return null;

      int? colorValue = color?.value;

      goalSchema.name = name;
      goalSchema.color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        goalSchema.id = await IsarDB.isar.goals.put(goalSchema);
      });

      final goal = GoalModel.fromSchema(goalSchema);

      return goal;
    } catch (error) {
      rethrow;
    }
  }
}
