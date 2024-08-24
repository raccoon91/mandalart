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
  List<GoalModel?>? _goals;
  GoalModel? _goal;
  List<PlanModel?>? _plans;
  PlanModel? _plan;

  String get mode => _mode;
  String? get visionName => _vision?.name;
  VisionModel? get vision => _vision;
  List<GoalModel?>? get goals => _goals;
  GoalModel? get goal => _goal;
  List<PlanModel?>? get plans => _plans;
  PlanModel? get plan => _plan;

  Future<bool> getVision() async {
    try {
      var vision = await VisionRepository().getVision();

      _vision = vision;
      _goals = vision?.goals;

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

      var goal = await GoalRepository().getGoal(goalId);

      _goal = goal;
      _plans = goal?.plans;

      return goal;
    } catch (error) {
      rethrow;
    }
  }

  Future<PlanModel?> getPlan(int? planId) async {
    try {
      if (planId == null) return null;

      var plan = await PlanRepository().getPlan(planId);

      _plan = plan;

      return plan;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> createVision(String name, Color color) async {
    try {
      var visionSchema = await VisionRepository().createVision(name, color);
      var goalSchemaList = await GoalRepository().createGoals(visionSchema);
      await PlanRepository().createPlans(visionSchema, goalSchemaList);

      var vision = await VisionRepository().getVision();

      _vision = vision;
      _goals = vision?.goals;

      return vision == null;
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateGoal(int? goalId, String? name, Color? color) async {
    try {
      if (_vision == null || goalId == null) return;

      var success = await GoalRepository().updateGoal(goalId, name, color);

      if (!success) return;

      var vision = await VisionRepository().getVision();

      _vision = vision;
      _goals = vision?.goals;
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

      var success = await PlanRepository().updatePlan(planId, name, color);

      if (!success) return;

      var vision = await VisionRepository().getVision();
      var goal = await GoalRepository().getGoal(goalId);

      _vision = vision;
      _goals = vision?.goals;
      _goal = goal;
      _plans = goal?.plans;
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
    properties.add(DiagnosticsProperty<List<GoalModel?>>('goals', _goals));
    properties.add(DiagnosticsProperty<GoalModel>('goal', _goal));
    properties.add(DiagnosticsProperty<List<PlanModel?>>('plans', _plans));
    properties.add(DiagnosticsProperty<PlanModel>('plan', _plan));
  }
}
