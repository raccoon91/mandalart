import 'package:flutter/foundation.dart';
import 'package:mandalart/repository/project_repository.dart';

class SettingProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> deleteMandalProject() async {
    try {
      _isLoading = true;

      notifyListeners();

      bool success = await ProjectRepository().deleteProject();

      return success;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }
}
