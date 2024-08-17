import 'package:flutter/material.dart';
import 'package:mandalart/provider/goal_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/home/mandal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PlanBottomSheetScreen extends StatelessWidget {
  final String? mode;
  final String? goalId;
  final String? planId;

  const PlanBottomSheetScreen({
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
        if (mode == 'maximize') {
          await Provider.of<HomeProvider>(
            context,
            listen: false,
          ).updatePlan(
            goalId != null ? int.parse(goalId!) : null,
            planId != null ? int.parse(planId!) : null,
            name,
            color,
          );
        } else {
          await Provider.of<GoalProvider>(
            context,
            listen: false,
          ).updatePlan(
            goalId != null ? int.parse(goalId!) : null,
            planId != null ? int.parse(planId!) : null,
            name,
            color,
          );

          if (context.mounted) {
            await Provider.of<HomeProvider>(
              context,
              listen: false,
            ).getInProgressVision();
          }
        }

        if (!context.mounted) return;

        if (goalId != null) {
          Provider.of<ScheduleProvider>(context, listen: false).getPlans(
            int.parse(goalId!),
          );
        }
      },
    );
  }
}
