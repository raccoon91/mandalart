import 'package:flutter/foundation.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/repository/project_repository.dart';
import 'package:mandalart/repository/task_repository.dart';

class CalendarProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isEmpty = true;
  bool _isLoading = false;
  List<PlanModel?>? _plans;
  List<DetailedPlanModel?>? _detailedPlans;
  List<TaskModel>? _tasks;

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;
  List<PlanModel?>? get plans => _plans;
  List<DetailedPlanModel?>? get detailedPlans => _detailedPlans;
  List<TaskModel>? get tasks => _tasks;

  Future<void> getPlans() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();

      _isEmpty =
          project == null || project.plans == null || project.plans!.isEmpty;

      _plans = project?.plans
          ?.where((plan) => plan?.name?.isNotEmpty ?? false)
          .toList();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void getDetailedPlans(int? planId) async {
    try {
      if (_plans == null || planId == null) {
        _detailedPlans = null;

        return;
      }

      PlanModel? plan;

      for (var itme in _plans!) {
        if (itme?.id == planId) {
          plan = itme;

          break;
        }
      }

      if (plan != null) {
        _detailedPlans = plan.detailedPlans
            ?.where((detailedPlan) => detailedPlan?.name?.isNotEmpty ?? false)
            .toList();
      } else {
        _detailedPlans = null;
      }
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getTasks() async {
    try {
      _isLoading = true;

      notifyListeners();

      List<TaskModel>? tasks = await TaskRepository().getTodayTask();

      _tasks = tasks;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<bool> createTask(
    int detailedPlanId,
    DateTime from,
    DateTime to,
    bool? allDay,
    bool? everyDay,
    int? everyWeek,
    int? everyMonth,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      var newTask = await TaskRepository().createTask(
        detailedPlanId,
        from,
        to,
        allDay,
        everyDay,
        everyWeek,
        everyMonth,
      );

      List<TaskModel> tasks = _tasks ?? [];

      if (newTask == null) return false;

      tasks.add(newTask);

      _tasks = tasks;

      return true;
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
    properties.add(DiagnosticsProperty<List<PlanModel?>>('plans', _plans));
  }
}
