import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/repository/goal_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';

class GoalProvider with ChangeNotifier, DiagnosticableTreeMixin {
  GoalModel? _goal;

  GoalModel? get goal => _goal;

  Future<void> getGoal(String? goalId) async {
    try {
      if (goalId == null) return;

      GoalModel? goal = await GoalRepository.get(int.parse(goalId));

      _goal = goal;
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
      if (_goal == null || goalId == null || planId == null) return;

      PlanModel? newPlan = await PlanRepository.update(
        planId,
        name,
        color,
      );

      _goal!.plans = _goal!.plans
              ?.map((plan) => plan?.id == newPlan?.id ? newPlan : plan)
              .toList() ??
          [];
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void clearGoal() {
    _goal = null;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<GoalModel>('goal', _goal));
  }
}
