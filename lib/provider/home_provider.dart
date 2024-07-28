import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;
  ProjectModel? _project;
  List<PlanModel?>? _plans;

  bool get isEmpty => _project == null || _plans == null;
  bool get isLoading => _isLoading;
  ProjectModel? get project => _project;
  List<PlanModel?>? get plans => _plans;

  Future<bool> getMandalProject() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();
      List<PlanModel>? plans = await PlanRepository().getPlans(project?.id);

      _project = project;
      _plans = List.generate(8, (index) {
        if (plans == null || index >= plans.length) return null;

        PlanModel? plan = plans[index];

        return plan;
      });

      return project == null || plans == null;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> createMandalProject(String name, Color color) async {
    try {
      _isLoading = true;

      notifyListeners();

      _project = await ProjectRepository().createProjectWithEmptyPlans(
        name,
        color,
      );
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> upsertMandalPlan(
    int? projectId,
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      List<PlanModel>? plans;

      _isLoading = true;

      notifyListeners();

      if (planId == null) {
        await PlanRepository().createPlan(projectId, planId, name, color);
        plans = await PlanRepository().getPlans(project?.id);
      } else {
        await PlanRepository().updatePlan(planId, name, color);
        plans = await PlanRepository().getPlans(project?.id);
      }

      _plans = List.generate(8, (index) {
        if (plans == null || index >= plans.length) return null;

        PlanModel? plan = plans[index];

        return plan;
      });

      notifyListeners();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ProjectModel>('project', _project));
  }
}
