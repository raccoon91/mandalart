import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/home/plan_update_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PlanUpdateBottomSheetScreen extends StatelessWidget {
  final String? goalId;
  final String? planId;

  const PlanUpdateBottomSheetScreen({
    super.key,
    this.goalId,
    this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return PlanUpdateBottomSheet(
      planId: planId != null ? int.parse(planId!) : null,
      create: (String name, Color color) async {
        int? intGoalId = goalId != null ? int.parse(goalId!) : null;
        int? intPlanId = planId != null ? int.parse(planId!) : null;

        await Provider.of<HomeProvider>(context, listen: false).updatePlan(
          intGoalId,
          intPlanId,
          name,
          color,
        );

        if (!context.mounted) return;

        await Provider.of<ScheduleProvider>(context, listen: false).getPlans(
          intGoalId,
        );
      },
    );
  }
}
