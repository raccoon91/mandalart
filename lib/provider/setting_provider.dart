import 'package:flutter/foundation.dart';
import 'package:mandalart/repository/detailed_plan_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';
import 'package:mandalart/repository/task_repository.dart';

class SettingProvider with ChangeNotifier {
  bool _isLoading = false;
  int? _projectSize;
  int? _planSize;
  int? _detailedPlanSize;
  int? _taskSize;

  bool get isLoading => _isLoading;
  int? get projectSize => _projectSize;
  int? get planSize => _planSize;
  int? get detailedPlanSize => _detailedPlanSize;
  int? get taskSize => _taskSize;

  Future<void> getSizes() async {
    try {
      _isLoading = true;

      notifyListeners();

      _projectSize = await ProjectRepository().getProjectSize();
      _planSize = await PlanRepository().getPlanSize();
      _detailedPlanSize = await DetailedPlanRepository().getDetailedPlanSize();
      _taskSize = await TaskRepository().getTaskSize();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<bool> deleteDB() async {
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
