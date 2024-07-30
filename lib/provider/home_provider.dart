import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;
  ProjectModel? _project;

  bool get isEmpty => _project == null;
  bool get isLoading => _isLoading;
  ProjectModel? get project => _project;

  Future<bool> getProjectWithPlans() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();

      _project = project;

      return project == null;
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

      _project = await ProjectRepository().createMandalProject(
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
    String? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (_project == null) return;

      PlanModel? newPlan;

      _isLoading = true;

      notifyListeners();

      if (planId == null) {
        newPlan = await PlanRepository().createPlan(
          _project!.id,
          name,
          color,
        );
      } else {
        newPlan = await PlanRepository().updatePlan(
          int.parse(planId),
          name,
          color,
        );
      }

      _project!.plans = _project!.plans
              ?.map((plan) => plan?.id == newPlan?.id ? newPlan : plan)
              .toList() ??
          [];
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
