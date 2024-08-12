import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';
import 'package:mandalart/schema/task_schema.dart';

class ProjectRepository {
  Future<int?> getProjectSize() async {
    try {
      final projectSize = await IsarDB.isar.projects
          .getSize(includeIndexes: true, includeLinks: true);

      return projectSize;
    } catch (error) {
      rethrow;
    }
  }

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
      int colorValue = color.value;

      final projectSchema = Project()
        ..name = name
        ..color = colorValue
        ..progress = true;

      await IsarDB.isar.writeTxn(() async {
        int projectId = await IsarDB.isar.projects.put(projectSchema);

        for (int index = 0; index < 8; index++) {
          final planSchema = Plan()
            ..projectId = projectId
            ..order = index + 1;

          projectSchema.plans.add(planSchema);

          int planId = await IsarDB.isar.plans.put(planSchema);

          for (int index = 0; index < 8; index++) {
            final detailedPlanSchema = DetailedPlan()
              ..planId = planId
              ..order = index + 1;

            planSchema.detailedPlans.add(detailedPlanSchema);

            await IsarDB.isar.detailedPlans.put(detailedPlanSchema);
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

      List<Task> taskSchema = await IsarDB.isar.tasks.where().findAll();

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
      List<int> taskIds = taskSchema.map((task) => task.id).toList();

      await IsarDB.isar.writeTxn(() async {
        await IsarDB.isar.tasks.deleteAll(taskIds);
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
