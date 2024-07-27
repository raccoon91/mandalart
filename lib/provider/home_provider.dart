import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProjectModel? _project;

  bool get isEmpty => _project == null;
  ProjectModel? get project => _project;

  Future<bool> getProject() async {
    bool isEmpty = true;

    try {
      _project = await ProjectRepository().getProject();

      isEmpty = _project == null;

      notifyListeners();

      return isEmpty;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createProject(String name, Color color) async {
    try {
      _project = await ProjectRepository().createProject(name, color);
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
