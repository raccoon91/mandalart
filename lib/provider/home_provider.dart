import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/main_target_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProjectModel? _project;
  List<MainTargetModel>? _mainTargets;

  bool get isEmpty => _project == null || _mainTargets == null;
  ProjectModel? get project => _project;
  List<MainTargetModel>? get mainTargets => _mainTargets;

  Future<bool> getMandal() async {
    try {
      ProjectModel? project = await ProjectRepository().getProject();
      List<MainTargetModel>? mainTargets =
          await MainTargetRepository().getMainTargets(project?.id);

      _project = project;
      _mainTargets = mainTargets;

      notifyListeners();

      return project == null || mainTargets == null;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createMandal(String name, Color color) async {
    try {
      _project = await ProjectRepository().createProjectWithEmptyMainTargets(
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
