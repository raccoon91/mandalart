import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/main.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/schema/detailed_plan_schema.dart';
import 'package:mandalart/schema/plan_schema.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectRepository {
  Future<String?> getProjectName() async {
    try {
      final projectSchema =
          await isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      return projectSchema.name;
    } catch (error) {
      rethrow;
    }
  }

  Future<ProjectModel?> getProject() async {
    try {
      final projectSchema =
          await isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return null;

      final planSchemaList = await isar.plans
          .filter()
          .projectIdEqualTo(projectSchema.id)
          .findAll();

      List<PlanModel> plans = [];

      for (var planSchema in planSchemaList) {
        final detailedPlanSchemaList = await isar.detailedPlans
            .filter()
            .planIdEqualTo(planSchema.id)
            .findAll();

        List<DetailedPlanModel> detailedPlans =
            detailedPlanSchemaList.map(DetailedPlanModel.fromSchema).toList();

        plans.add(PlanModel.fromSchema(planSchema, detailedPlans));
      }

      final project = ProjectModel.fromSchema(projectSchema, plans);

      return project;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createMandalProject(
    String name,
    Color color,
  ) async {
    try {
      int colorValue = color.value;

      isar.writeTxnSync(() {
        final projectSchema = Project()
          ..name = name
          ..color = colorValue
          ..progress = true;

        int projectId = isar.projects.putSync(projectSchema);

        for (int index = 0; index < 8; index++) {
          final planSchema = Plan()..projectId = projectId;

          int planId = isar.plans.putSync(planSchema);

          for (int index = 0; index < 8; index++) {
            final detailedPlanSchema = DetailedPlan()
              ..projectId = projectId
              ..planId = planId;

            isar.detailedPlans.putSync(detailedPlanSchema);
          }
        }
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> deleteProject() async {
    try {
      final projectSchema =
          await isar.projects.filter().progressEqualTo(true).findFirst();

      if (projectSchema == null) return false;

      int proejctId = projectSchema.id;

      final planSchemaList =
          await isar.plans.filter().projectIdEqualTo(proejctId).findAll();
      final detailedPlanSchemaList = await isar.detailedPlans
          .filter()
          .projectIdEqualTo(proejctId)
          .findAll();

      List<int> planIds = planSchemaList.map((schema) => schema.id).toList();
      List<int> detailedPlanIds =
          detailedPlanSchemaList.map((schema) => schema.id).toList();

      await isar.writeTxn(() async {
        await isar.detailedPlans.deleteAll(detailedPlanIds);
        await isar.plans.deleteAll(planIds);
        await isar.projects.delete(proejctId);
      });

      return true;
    } catch (error) {
      rethrow;
    }
  }
}
