import 'package:flutter/material.dart';
import 'package:mandalart/provider/goal_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/home/goal_update_bottom_sheet.dart';
import 'package:provider/provider.dart';

class GoalUpdateBottomSheetScreen extends StatelessWidget {
  final String? goalId;

  const GoalUpdateBottomSheetScreen({
    super.key,
    this.goalId,
  });

  @override
  Widget build(BuildContext context) {
    return GoalUpdateBottomSheet(
      goalId: goalId != null ? int.parse(goalId!) : null,
      create: (String name, Color color) async {
        await Provider.of<HomeProvider>(
          context,
          listen: false,
        ).updateGoal(
          goalId != null ? int.parse(goalId!) : null,
          name,
          color,
        );

        if (!context.mounted) return;

        await Provider.of<GoalProvider>(
          context,
          listen: false,
        ).getGoal(goalId);

        if (!context.mounted) return;

        await Provider.of<ScheduleProvider>(
          context,
          listen: false,
        ).getGoals();
      },
    );
  }
}
