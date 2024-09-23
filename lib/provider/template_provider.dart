import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/goal_template_model.dart';
import 'package:mandalart/model/plan_template_model.dart';
import 'package:mandalart/repository/goal_repository.dart';
import 'package:mandalart/repository/goal_template_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/plan_template_repository.dart';

class TemplateProvider with ChangeNotifier, DiagnosticableTreeMixin {
  GoalTemplateModel? _selectedGoalTemplate;
  PlanTemplateModel? _selectedPlanTemplate;
  List<GoalTemplateModel> _goalTemplates = [];
  List<PlanTemplateModel> _planTemplates = [];

  GoalTemplateModel? get selectedGoalTemplate => _selectedGoalTemplate;
  PlanTemplateModel? get selectedPlanTemplate => _selectedPlanTemplate;
  List<GoalTemplateModel> get goalTemplates => _goalTemplates;
  List<PlanTemplateModel> get planTemplates => _planTemplates;

  Future<void> getGoalTemplates({int? goalId}) async {
    try {
      if (goalId != null) {
        var goal = await GoalRepository().getGoal(goalId: goalId);

        _selectedGoalTemplate = goal?.goalTemplate != null ? GoalTemplateModel.fromSchema(goal!.goalTemplate!) : null;
      }

      _goalTemplates = await GoalTemplateRepository().getGoalTemplates();
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<GoalTemplateModel?> getGoalTemplate({int? goalTemplateId}) async {
    try {
      if (goalTemplateId == null) return null;

      var goalTemplate = await GoalTemplateRepository().getGoalTemplate(goalTemplateId: goalTemplateId);

      if (goalTemplate == null) return null;

      return GoalTemplateModel.fromSchema(goalTemplate);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getPlanTemplates({int? goalId, int? planId}) async {
    try {
      if (goalId == null) return;

      var goal = await GoalRepository().getGoal(goalId: goalId);

      if (goal == null || goal.goalTemplate == null) return;

      if (planId != null) {
        var plan = await PlanRepository().getPlan(planId: planId);

        _selectedPlanTemplate = plan?.planTemplate != null ? PlanTemplateModel.fromSchema(plan!.planTemplate!) : null;
      }

      _selectedGoalTemplate = GoalTemplateModel.fromSchema(goal.goalTemplate!);
      _planTemplates = _selectedGoalTemplate?.planTemplates ?? [];
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<PlanTemplateModel?> getPlanTemplate({int? planTemplateId}) async {
    try {
      if (planTemplateId == null) return null;

      var planTemplate = await PlanTemplateRepository().getPlanTemplate(planTemplateId: planTemplateId);

      if (planTemplate == null) return null;

      return PlanTemplateModel.fromSchema(planTemplate);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> upsertGoalTemplate({int? goalTemplateId, required String name, Color? color}) async {
    try {
      if (goalTemplateId == null) {
        await GoalTemplateRepository().createGoalTemplate(name: name, color: color);
      } else {
        await GoalTemplateRepository().updateGoalTemplate(goalTemplateId: goalTemplateId, name: name, color: color);
      }
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  Future<void> upsertPlanTemplate({int? goalId, int? planTemplateId, required String name, Color? color}) async {
    try {
      if (goalId == null) return;

      var goal = await GoalRepository().getGoal(goalId: goalId);

      if (planTemplateId == null) {
        await PlanTemplateRepository().createPlanTemplate(goalTemplate: goal?.goalTemplate, name: name, color: color);
      } else {
        await PlanTemplateRepository().updatePlanTemplate(planTemplateId: planTemplateId, name: name, color: color);
      }
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void selectGoalTemplate({GoalTemplateModel? goalTemplate}) {
    if (goalTemplate == null || _selectedGoalTemplate?.id == goalTemplate.id) {
      _selectedGoalTemplate = null;
    } else {
      _selectedGoalTemplate = goalTemplate;
    }

    _selectedPlanTemplate = null;
    _planTemplates = [];

    notifyListeners();
  }

  void selectPlanTemplate({PlanTemplateModel? planTemplate}) {
    if (planTemplate == null || _selectedPlanTemplate?.id == planTemplate.id) {
      _selectedPlanTemplate = null;
    } else {
      _selectedPlanTemplate = planTemplate;
    }

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<GoalTemplateModel>>('goalTemplates', _goalTemplates));
    properties.add(DiagnosticsProperty<List<PlanTemplateModel>>('planTemplates', _planTemplates));
  }
}
