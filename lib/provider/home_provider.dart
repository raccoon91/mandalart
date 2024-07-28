import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProjectModel? _project;
  List<PlanModel>? _plans;

  bool get isEmpty => _project == null || _plans == null;
  ProjectModel? get project => _project;
  List<PlanModel>? get plans => _plans;

  Future<bool> getMandal() async {
    try {
      ProjectModel? project = await ProjectRepository().getProject();
      List<PlanModel>? plans = await PlanRepository().getPlans(project?.id);

      _project = project;
      _plans = plans;

      notifyListeners();

      return project == null || plans == null;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createMandal(String name, Color color) async {
    try {
      _project = await ProjectRepository().createProjectWithEmptyPlans(
        name,
        color,
      );
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ProjectModel>('project', _project));
  }
}
