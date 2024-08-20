import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/vision_model.dart';
import 'package:mandalart/repository/goal_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/vision_repository.dart';

class HomeProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String _mode = 'minimize';
  VisionModel? _vision;

  String get mode => _mode;
  String? get visionName => _vision?.name;
  VisionModel? get vision => _vision;

  Future<bool> getInProgressVision() async {
    try {
      VisionModel? vision = await VisionRepository.get();

      _vision = vision;

      return vision == null;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<GoalModel?> getGoal(int? goalId) async {
    try {
      if (goalId == null) return null;

      var goal = GoalRepository.get(goalId);

      return goal;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlanModel?> getPlan(int? planId) async {
    try {
      if (planId == null) return null;

      var plan = PlanRepository.get(planId);

      return plan;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createVision(String name, Color color) async {
    try {
      _vision = await VisionRepository.create(name, color);
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateGoal(
    int? goalId,
    String? name,
    Color? color,
  ) async {
    try {
      if (_vision == null || goalId == null) return;

      GoalModel? newGoal = await GoalRepository.update(goalId, name, color);

      if (_vision?.goals == null) return;

      _vision!.goals = _vision!.goals
              ?.map((goal) => goal?.id == newGoal?.id ? newGoal : goal)
              .toList() ??
          [];
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updatePlan(
    int? goalId,
    int? planId,
    String? name,
    Color? color,
  ) async {
    try {
      if (_vision == null || planId == null) return;

      PlanModel? newPlan = await PlanRepository.update(planId, name, color);

      if (_vision?.goals == null) return;

      _vision!.goals = _vision!.goals?.map((goal) {
            if (goal == null || goal.id != goalId || goal.plans == null) {
              return goal;
            }

            goal.plans = goal.plans
                    ?.map((plan) => plan?.id == newPlan?.id ? newPlan : plan)
                    .toList() ??
                [];

            return goal;
          }).toList() ??
          [];
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void changeMode() {
    _mode = _mode == 'minimize' ? 'maximize' : 'minimize';

    notifyListeners();
  }

  void clearHome() {
    _vision = null;
    _mode = 'minimize';

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('mode', _mode));
    properties.add(DiagnosticsProperty<VisionModel>('vision', _vision));
  }
}
