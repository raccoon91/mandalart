import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/vision_model.dart';
import 'package:mandalart/schema/goal_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/schedule_schema.dart';
import 'package:mandalart/schema/task_schema.dart';
import 'package:mandalart/schema/vision_schema.dart';

class VisionRepository {
  static Future<int> getSize() async {
    try {
      final size = await IsarDB.isar.visions.getSize(
        includeIndexes: true,
        includeLinks: true,
      );

      return size;
    } catch (error) {
      rethrow;
    }
  }

  static Future<String?> getName() async {
    try {
      final visionSchema = await IsarDB.isar.visions
          .filter()
          .inProgressEqualTo(true)
          .isDeleteEqualTo(false)
          .findFirst();

      if (visionSchema == null) return null;

      return visionSchema.name;
    } catch (error) {
      rethrow;
    }
  }

  static Future<VisionModel?> get() async {
    try {
      final visionSchema = await IsarDB.isar.visions
          .filter()
          .inProgressEqualTo(true)
          .isDeleteEqualTo(false)
          .findFirst();

      if (visionSchema == null) return null;

      final vision = VisionModel.fromSchema(visionSchema);

      return vision;
    } catch (error) {
      rethrow;
    }
  }

  static Future<VisionModel> create(
    String name,
    Color color,
  ) async {
    try {
      int colorValue = color.value;

      final visionSchema = Vision()
        ..name = name
        ..color = colorValue
        ..inProgress = true;

      await IsarDB.isar.writeTxn(() async {
        int visionId = await IsarDB.isar.visions.put(visionSchema);

        for (int index = 0; index < 8; index++) {
          final goalSchema = Goal()
            ..visionId = visionId
            ..order = index;

          visionSchema.goals.add(goalSchema);

          int goalId = await IsarDB.isar.goals.put(goalSchema);

          for (int index = 0; index < 8; index++) {
            final planSchema = Plan()
              ..visionId = visionId
              ..goalId = goalId
              ..order = index;

            goalSchema.plans.add(planSchema);

            await IsarDB.isar.plans.put(planSchema);
          }

          await goalSchema.plans.save();
        }

        await visionSchema.goals.save();
      });

      final vision = VisionModel.fromSchema(visionSchema);

      return vision;
    } catch (error) {
      rethrow;
    }
  }

  static Future<bool> delete() async {
    try {
      final visionSchema = await IsarDB.isar.visions
          .filter()
          .inProgressEqualTo(true)
          .isDeleteEqualTo(false)
          .findFirst();

      if (visionSchema == null) return false;

      var visionId = visionSchema.id;

      List<int> goalIds = visionSchema.goals.map((planShcema) {
        return planShcema.id;
      }).toList();

      List<int> planIds = visionSchema.goals.fold(
        [],
        (acc, goalSchema) {
          for (var planSchema in goalSchema.plans) {
            acc.add(planSchema.id);
          }

          return acc;
        },
      );

      List<Schedule> scheduleSchema = await IsarDB.isar.schedules
          .filter()
          .visionIdEqualTo(visionId)
          .findAll();

      List<int> scheduleIds =
          scheduleSchema.map((schedule) => schedule.id).toList();

      List<Task> taskSchema =
          await IsarDB.isar.tasks.filter().visionIdEqualTo(visionId).findAll();

      List<int> taskIds = taskSchema.map((task) => task.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.deleteAll(taskIds);
        await IsarDB.isar.schedules.deleteAll(scheduleIds);
        await IsarDB.isar.plans.deleteAll(planIds);
        await IsarDB.isar.goals.deleteAll(goalIds);
        await IsarDB.isar.visions.delete(visionId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
