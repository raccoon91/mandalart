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

  Future<PlanModel?> getEmptyMandal() async {
    try {
      if (_plans == null || _plans!.isEmpty) return null;

      PlanModel? result;

      for (int index = 0; index < 8; index++) {
        PlanModel? plan = _plans?[index];

        if (plan == null) continue;

        if (plan.name == null) {
          result = plan;

          break;
        }
      }

      return result;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> upsertMandalPlan(
    String projectId,
    String? planId,
    String? name,
    Color? color,
  ) async {
    try {
      List<PlanModel>? plans;

      _isLoading = true;

      notifyListeners();

      if (planId == null) {
        await PlanRepository().createPlan(int.parse(projectId), name, color);
        plans = await PlanRepository().getPlans(project?.id);
      } else {
        await PlanRepository().updatePlan(int.parse(planId), name, color);
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
