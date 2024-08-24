import 'package:flutter/foundation.dart';
import 'package:mandalart/repository/complete_repository.dart';
import 'package:mandalart/repository/goal_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/schedule_repository.dart';
import 'package:mandalart/repository/vision_repository.dart';

class SettingProvider with ChangeNotifier {
  int? _visionSize;
  int? _goalSize;
  int? _planSize;
  int? _scheduleSize;
  int? _completeSize;

  int? get visionSize => _visionSize;
  int? get goalSize => _goalSize;
  int? get planSize => _planSize;
  int? get scheduleSize => _scheduleSize;
  int? get completeSize => _completeSize;

  Future<void> getSizes() async {
    try {
      _visionSize = await VisionRepository().getSize();
      _goalSize = await GoalRepository().getSize();
      _planSize = await PlanRepository().getSize();
      _scheduleSize = await ScheduleRepository().getSize();
      _completeSize = await CompleteRepository().getSize();
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteDB() async {
    try {
      var vision = await VisionRepository().getVision();

      if (vision == null) return false;

      await CompleteRepository().deleteAllComplete(vision.id);
      await ScheduleRepository().deleteAllSchedule(vision.id);
      await PlanRepository().deleteAllPlan(vision.id);
      await GoalRepository().deleteAllGoal(vision.id);
      await VisionRepository().deleteVision(vision.id);

      return true;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
