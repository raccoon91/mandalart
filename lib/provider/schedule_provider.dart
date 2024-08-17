import 'package:flutter/foundation.dart';
import 'package:mandalart/model/appointment_model.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/model/vision_model.dart';
import 'package:mandalart/repository/schedule_repository.dart';
import 'package:mandalart/repository/vision_repository.dart';
import 'package:mandalart/utils/calendar_data.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleProvider with ChangeNotifier, DiagnosticableTreeMixin {
  DateTime? _start;
  DateTime? _end;

  List<GoalModel?>? _goals;
  List<PlanModel?>? _plans;

  ScheduleModel? _schedule;
  List<ScheduleModel> _schedules = [];
  List<Appointment> _appointments = [];

  List<GoalModel?>? get goals => _goals;
  List<PlanModel?>? get plans => _plans;

  ScheduleModel? get schedule => _schedule;
  List<ScheduleModel> get schedules => _schedules;

  CalendarData get appointments => CalendarData(_appointments);

  Future<void> getGoals() async {
    try {
      VisionModel? vision = await VisionRepository.get();

      _goals = vision?.goals
          ?.where((goal) => goal?.name?.isNotEmpty ?? false)
          .toList();
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getPlans(int? goalId) async {
    try {
      if (_goals == null || goalId == null) {
        _plans = null;

        return;
      }

      GoalModel? goal = _goals?.where((goal) => goal?.id == goalId).first;

      if (goal != null) {
        _plans = goal.plans
            ?.where((plan) => plan?.name?.isNotEmpty ?? false)
            .toList();
      } else {
        _plans = null;
      }
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSchedule(int scheduleId) async {
    try {
      var schedule = await ScheduleRepository.get(scheduleId);

      var goalId = schedule?.plan?.goalId;

      GoalModel? goal = _goals?.where((goal) => goal?.id == goalId).first;

      if (goal != null) {
        _plans = goal.plans
            ?.where((plan) => plan?.name?.isNotEmpty ?? false)
            .toList();
      } else {
        _plans = null;
      }

      _schedule = schedule;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> getSchedules(DateTime? from, DateTime? to) async {
    try {
      if (from != null) _start = from;
      if (to != null) _end = to;

      if (_start == null || _end == null) return;

      List<Appointment> appointments = [];

      var weekSchedules = await ScheduleRepository.getThisWeek(_start!);
      var weekDaySchedules = await ScheduleRepository.getWeekDay(_start!);
      var weekendSchedules = await ScheduleRepository.getWeekend(_start!);
      var everyDaySchedules = await ScheduleRepository.getEveryDay(_start!);
      var everyWeekSchedules = await ScheduleRepository.getEveryWeek(_start!);
      var everyMonthSchedules = await ScheduleRepository.getEveryMonth(_start!);

      List<ScheduleModel> schedules = [
        ...(weekDaySchedules ?? []),
        ...(weekendSchedules ?? []),
        ...(weekSchedules ?? []),
        ...(everyDaySchedules ?? []),
        ...(everyWeekSchedules ?? []),
        ...(everyMonthSchedules ?? []),
      ];

      for (ScheduleModel schedule in schedules) {
        appointments.add(AppointmentModel.fromSchema(schedule));
      }

      _schedules = schedules;
      _appointments = appointments;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> createSchedule(
    int planId,
    DateTime from,
    DateTime to,
    bool? isAllDay,
    String? repeat,
  ) async {
    try {
      var vision = await VisionRepository.get();

      if (vision == null) return false;

      var newSchedule = await ScheduleRepository.create(
        vision.id,
        planId,
        from,
        to,
        isAllDay,
        repeat,
      );

      List<ScheduleModel> schedules = [..._schedules];

      if (newSchedule == null) return false;

      schedules.add(newSchedule);

      _schedules = schedules;

      _appointments = schedules.map((schedule) {
        return AppointmentModel.fromSchema(schedule);
      }).toList();

      return true;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteSchedule(int scheduleId) async {
    try {
      var success = await ScheduleRepository.delete(scheduleId);

      if (!success) return;

      _schedule = null;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> stopSchedule(int scheduleId, DateTime terminated) async {
    try {
      var success = await ScheduleRepository.stop(scheduleId, terminated);

      if (!success) return;

      _schedule = null;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void clearSchedule() {
    _schedule = null;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<PlanModel?>>('plans', _plans));
    properties.add(
      DiagnosticsProperty<List<ScheduleModel>>('schedules', _schedules),
    );
  }
}
