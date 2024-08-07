import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

      _isEmpty = project == null ||
          project.plans == null ||
          project.plans?.isEmpty == true;

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

      await ProjectRepository().createMandalProject(name, color);

      ProjectModel? project = await ProjectRepository().getProject();

      _project = project;

      _isEmpty = project == null ||
          project.plans == null ||
          project.plans?.isEmpty == true;
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
      if (_project == null || _project?.id == null) return;

      _isLoading = true;

      notifyListeners();

      if (planId == null) {
        await PlanRepository().createPlan(_project!.id, name, color);
      } else {
        await PlanRepository().updatePlan(planId, name, color);
      }

      var plans = await PlanRepository().getPlans(_project!.id);

      if (plans == null) return;

      _project!.plans = plans;
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

      _isLoading = true;

      notifyListeners();

      if (detailedPlanId == null) {
        await DetailedPlanRepository().createDetailedPlan(
          planId,
          name,
          color,
        );
      } else {
        await DetailedPlanRepository().updateDetailedPlan(
          detailedPlanId,
          name,
          color,
        );
      }

      var plans = await PlanRepository().getPlans(_project!.id);

      if (plans == null) return;

      _project!.plans = plans;
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
