import 'package:flutter/foundation.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/model/task_model.dart';
import 'package:mandalart/repository/project_repository.dart';
import 'package:mandalart/repository/task_repository.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/utils/task_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isEmpty = true;
  bool _isLoading = false;
  List<PlanModel?>? _plans;
  List<DetailedPlanModel?>? _detailedPlans;
  List<Appointment> _tasks = [];

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;
  List<PlanModel?>? get plans => _plans;
  List<DetailedPlanModel?>? get detailedPlans => _detailedPlans;
  TaskDataSource get tasks => TaskDataSource(_tasks);

  Future<void> getPlans() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();

      _isEmpty = project == null ||
          project.plans == null ||
          project.plans?.isEmpty == true;

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

  Future<void> getTasks(DateTime from, DateTime to) async {
    try {
      _isLoading = true;

      notifyListeners();

      List<Appointment> tasks = [];

      var weekTasks = await TaskRepository().getWeekTasks(from, to);
      var everyDayTasks = await TaskRepository().getEveryDayTask(from);
      var everyWeekTasks = await TaskRepository().getEveryWeekTask(from);

      for (TaskModel task in weekTasks ?? []) {
        tasks.add(Appointment(
          startTime: task.from,
          endTime: task.to,
          subject: task.detailedPlan.name ?? '',
          color: task.detailedPlan.color ?? ColorClass.under,
          isAllDay: task.allDay,
        ));
      }

      for (TaskModel task in everyDayTasks ?? []) {
        tasks.add(Appointment(
          startTime: task.from,
          endTime: task.to,
          subject: task.detailedPlan.name ?? '',
          color: task.detailedPlan.color ?? ColorClass.under,
          isAllDay: task.allDay,
        ));
      }

      for (TaskModel task in everyWeekTasks ?? []) {
        tasks.add(Appointment(
          startTime: task.from,
          endTime: task.to,
          subject: task.detailedPlan.name ?? '',
          color: task.detailedPlan.color ?? ColorClass.under,
          isAllDay: task.allDay,
        ));
      }

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
    String? repeat,
  ) async {
    try {
      _isLoading = true;

      notifyListeners();

      var newTask = await TaskRepository().createTask(
        detailedPlanId,
        from,
        to,
        allDay,
        repeat,
      );

      List<Appointment> tasks = [..._tasks];

      if (newTask == null) return false;

      tasks.add(
        Appointment(
          startTime: newTask.from,
          endTime: newTask.to,
          subject: newTask.detailedPlan.name ?? '',
          color: newTask.detailedPlan.color ?? ColorClass.under,
          isAllDay: newTask.allDay,
        ),
      );

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
