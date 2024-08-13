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

  DateTime? _start;
  DateTime? _end;

  List<PlanModel?>? _plans;
  List<DetailedPlanModel?>? _detailedPlans;
  TaskModel? _task;
  List<Appointment> _tasks = [];

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;

  List<PlanModel?>? get plans => _plans;
  List<DetailedPlanModel?>? get detailedPlans => _detailedPlans;
  TaskModel? get task => _task;
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

  Future<void> getDetailedPlans(int? planId) async {
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

  Future<void> getTask(int taskId) async {
    try {
      _isLoading = true;

      notifyListeners();

      var task = await TaskRepository().getTask(taskId);

      if (task?.detailedPlan.planId != null) {
        await getDetailedPlans(task?.detailedPlan.planId);
      }

      _task = task;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> getTasks(DateTime? from, DateTime? to) async {
    try {
      _isLoading = true;

      notifyListeners();

      if (from != null) _start = from;
      if (to != null) _end = to;

      if (_start == null || _end == null) return;

      List<Appointment> appointments = [];

      var weekDayTasks = await TaskRepository().getWeekDayTasks(_start!);
      var weekendTasks = await TaskRepository().getWeekendTasks(_start!);
      var weekTasks = await TaskRepository().getWeekTasks(_start!);
      var everyDayTasks = await TaskRepository().getEveryDayTask(_start!);
      var everyWeekTasks = await TaskRepository().getEveryWeekTask(_start!);
      var everyMonthTasks = await TaskRepository().getEveryMonthTask(_start!);

      List<TaskModel> tasks = [
        ...(weekDayTasks ?? []),
        ...(weekendTasks ?? []),
        ...(weekTasks ?? []),
        ...(everyDayTasks ?? []),
        ...(everyWeekTasks ?? []),
        ...(everyMonthTasks ?? []),
      ];

      for (TaskModel task in tasks) {
        appointments.add(Appointment(
          subject: task.detailedPlan.name ?? '',
          startTime: task.from,
          endTime: task.to,
          isAllDay: task.allDay,
          color: task.detailedPlan.color ?? ColorClass.under,
          resourceIds: [
            {"taskId": task.id}
          ],
        ));
      }

      _tasks = appointments;
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

  Future<void> deleteTask(int taskId) async {
    try {
      _isLoading = true;

      notifyListeners();

      var success = await TaskRepository().deleteTask(taskId);

      if (!success) return;

      _task = null;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> stopTask(int taskId, DateTime terminate) async {
    try {
      _isLoading = true;

      notifyListeners();

      var success = await TaskRepository().stopTask(taskId, terminate);

      if (!success) return;

      _task = null;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void clearTask() {
    _task = null;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<PlanModel?>>('plans', _plans));
  }
}
