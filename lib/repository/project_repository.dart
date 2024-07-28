import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/schema/main_target_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectRepository {
  Future<ProjectModel?> getProject() async {
    try {
      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final project = ProjectModel.fromJson(projectSchema);

      return project;
    } catch (error) {
      rethrow;
    }
  }

  Future<ProjectModel> createProjectWithEmptyMainTargets(
    String name,
    Color color,
  ) async {
    try {
      String colorString = color.toString();
      String colorInteger = colorString.split('(0x')[1].split(')')[0];
      int colorValue = int.parse(colorInteger, radix: 16);

      final projectSchema = Project()
        ..name = name
        ..color = colorValue
        ..progress = true;

      await IsarDB.isar.writeTxn(() async {
        int projectId = await IsarDB.isar.projects.put(projectSchema);

        for (int index = 0; index < 8; index++) {
          final mainTargetSchema = MainTarget()..projectId = projectId;

          await IsarDB.isar.mainTargets.put(
            mainTargetSchema,
          );
        }
      });

      final project = ProjectModel.fromJson(projectSchema);

      return project;
    } catch (error) {
      rethrow;
    }
  }
}
