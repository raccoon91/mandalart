import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectRepository {
  Future<String?> getProjectName() async {
    try {
      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      return projectSchema.name;
    } catch (error) {
      rethrow;
    }
  }

  Future<ProjectModel?> getProject() async {
    try {
      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final project = ProjectModel.fromSchema(projectSchema);

      return project;
    } catch (error) {
      rethrow;
    }
  }

  Future<ProjectModel> createMandalProject(
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
          final planSchema = Plan()..projectId = projectId;

          projectSchema.plans.add(planSchema);

          int planId = await IsarDB.isar.plans.put(
            planSchema,
          );

          for (int index = 0; index < 8; index++) {
            final detailedPlanSchema = DetailedPlan()..planId = planId;

            planSchema.detailedPlans.add(detailedPlanSchema);

            await IsarDB.isar.detailedPlans.put(
              detailedPlanSchema,
            );
          }

          await planSchema.detailedPlans.save();
        }

        await projectSchema.plans.save();
      });

      final project = ProjectModel.fromSchema(projectSchema);

      return project;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteProject() async {
    try {
      final projectSchema =
          await IsarDB.isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return false;

      int proejctId = projectSchema.id;
      List<int> planIds = projectSchema.plans
          .map(
            (planShcema) => planShcema.id,
          )
          .toList();
      List<int> detailedPlanIds = projectSchema.plans.fold(
        [],
        (acc, planShcema) {
          for (var detailedPlanSchema in planShcema.detailedPlans) {
            acc.add(detailedPlanSchema.id);
          }

          return acc;
        },
      );

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.detailedPlans.deleteAll(detailedPlanIds);
        await IsarDB.isar.plans.deleteAll(planIds);
        await IsarDB.isar.projects.delete(proejctId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
