import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/detailed_plan_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isEmpty = true;
  bool _isLoading = false;
  ProjectModel? _project;
  String _mode = 'minimize';

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;
  ProjectModel? get project => _project;
  String get mode => _mode;

  Future<bool> getProjectWithPlans() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();

      _project = project;

      _isEmpty =
          project == null || project.plans == null || project.plans!.isEmpty;

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
    int? planId,
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
          planId,
          name,
          color,
        );
      }

      if (_project?.plans == null) return;

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

  Future<void> upsertMandalDetailedPlan(
    int? planId,
    int? detailedPlanId,
    String? name,
    Color? color,
  ) async {
    try {
      if (_project == null || planId == null) return;

      DetailedPlanModel? newDetailedPlan;

      _isLoading = true;

      notifyListeners();

      if (detailedPlanId == null) {
        newDetailedPlan = await DetailedPlanRepository().createDetailedPlan(
          planId,
          name,
          color,
        );
      } else {
        newDetailedPlan = await DetailedPlanRepository().updateDetailedPlan(
          detailedPlanId,
          name,
          color,
        );
      }

      if (_project?.plans == null) return;

      _project!.plans = _project!.plans?.map(
            (plan) {
              if (plan == null) return null;

              if (plan.id != planId) return plan;

              if (plan.detailedPlans == null) return plan;

              plan.detailedPlans = plan.detailedPlans
                      ?.map(
                        (detailedPlan) =>
                            detailedPlan?.id == newDetailedPlan?.id
                                ? newDetailedPlan
                                : detailedPlan,
                      )
                      .toList() ??
                  [];

              return plan;
            },
          ).toList() ??
          [];
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void changeMode() {
    _mode = _mode == 'minimize' ? 'maximize' : 'minimize';

    notifyListeners();
  }

  Future<bool> deleteMandalProject() async {
    try {
      _isLoading = true;

      notifyListeners();

      bool success = await ProjectRepository().deleteProject();

      if (success) {
        _project = null;
        _isEmpty = true;
      }

      return success;
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
