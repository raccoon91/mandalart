import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/repository/detailed_plan_repository.dart';
import 'package:mandalart/repository/plan_repository.dart';
import 'package:mandalart/repository/project_repository.dart';

class PlanProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isEmpty = true;
  bool _isLoading = false;
  String? _proejctName;
  PlanModel? _plan;

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;
  String? get proejctName => _proejctName;
  PlanModel? get plan => _plan;

  Future<bool> getPlanWithDetailedPlans(String? planId) async {
    try {
      if (planId == null) return false;

      _proejctName = await ProjectRepository().getProjectName();

      _isLoading = true;

      notifyListeners();

      PlanModel? plan = await PlanRepository().getPlan(int.parse(planId));

      _plan = plan;

      _isEmpty = plan == null ||
          plan.detailedPlans == null ||
          plan.detailedPlans!.isEmpty;

      return plan == null;
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> upsertMandalDetailedPlan(
    int? planId,
    int? detailedPlanId,
    String? name,
    Color? color,
  ) async {
    try {
      if (_plan == null || planId == null) return;

      DetailedPlanModel? newDetailedPlan;

      _isLoading = true;

      notifyListeners();

      if (detailedPlanId == null) {
        newDetailedPlan = await DetailedPlanRepository().createDetailedPlan(
          planId,
          name,
          color,
        );
      } else {
        newDetailedPlan = await DetailedPlanRepository().updateDetailedPlan(
          detailedPlanId,
          name,
          color,
        );
      }

      _plan!.detailedPlans = _plan!.detailedPlans
              ?.map(
                (detailedPlan) => detailedPlan?.id == newDetailedPlan?.id
                    ? newDetailedPlan
                    : detailedPlan,
              )
              .toList() ??
          [];
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  void clearPlan() {
    _plan = null;
    _isEmpty = true;

    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<PlanModel>('plan', _plan));
  }
}