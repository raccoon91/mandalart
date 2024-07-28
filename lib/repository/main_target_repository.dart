import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/schema/main_target_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class MainTargetRepository {
  Future<List<MainTargetModel>?> getMainTargets(int? projectId) async {
    try {
      if (projectId == null) return null;

      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final mainTargetsSchema = await IsarDB.isar.mainTargets
          .filter()
          .projectIdEqualTo(projectId)
          .findAll();

      List<MainTargetModel> mainTargets =
          mainTargetsSchema.map(MainTargetModel.fromJson).toList();

      return mainTargets;
    } catch (error) {
      rethrow;
    }
  }

  Future<MainTargetModel?> createMainTarget(
    int? projectId,
    String name,
    Color color,
  ) async {
    try {
      if (projectId == null) return null;

      final projectSchema =
          await IsarDB.isar.projects.where().idEqualTo(projectId).findFirst();

      if (projectSchema == null) return null;

      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      final mainTargetSchema = MainTarget()
        ..name = name
        ..color = colorValue;

      await IsarDB.isar.writeTxn(() async {
        mainTargetSchema.id = await IsarDB.isar.mainTargets.put(
          mainTargetSchema,
        );
      });

      final mainTarget = MainTargetModel.fromJson(mainTargetSchema);

      return mainTarget;
    } catch (error) {
      rethrow;
    }
  }
}
