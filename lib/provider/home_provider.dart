import 'package:flutter/foundation.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/project_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  ProjectModel? _project;

  bool get isEmpty => _project == null;
  ProjectModel? get project => _project;

  Future<void> getProject() async {
    try {
      _project = await ProjectRepository().getProject();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createProject(String name) async {
    try {
      _project = await ProjectRepository().createProject(name);
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
