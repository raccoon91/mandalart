import 'package:flutter/foundation.dart';
import 'package:mandalart/repository/goal_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/schedule_repository.dart';
import 'package:mandalart/repository/task_repository.dart';
import 'package:mandalart/repository/vision_repository.dart';

class SettingProvider with ChangeNotifier {
  int? _visionSize;
  int? _goalSize;
  int? _planSize;
  int? _scheduleSize;
  int? _taskSize;

  int? get visionSize => _visionSize;
  int? get goalSize => _goalSize;
  int? get planSize => _planSize;
  int? get scheduleSize => _scheduleSize;
  int? get taskSize => _taskSize;

  Future<void> getSizes() async {
    try {
      _visionSize = await VisionRepository.getSize();
      _goalSize = await GoalRepository.getSize();
      _planSize = await PlanRepository.getSize();
      _scheduleSize = await ScheduleRepository.getSize();
      _taskSize = await TaskRepository.getSize();
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteDB() async {
    try {
      bool success = await VisionRepository.delete();

      return success;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }
}
