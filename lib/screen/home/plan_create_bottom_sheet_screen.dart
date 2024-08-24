import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/home/mandal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PlanCreateBottomSheetScreen extends StatelessWidget {
  final String? mode;
  final String? goalId;
  final String? planId;

  const PlanCreateBottomSheetScreen({
    super.key,
    this.mode,
    this.goalId,
    this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return MandalBottomSheet(
      type: 'plan',
      goalId: planId != null ? int.parse(planId!) : null,
      planId: goalId != null ? int.parse(goalId!) : null,
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
