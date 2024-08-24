import 'package:flutter/material.dart';
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
        int? intGoalId = goalId != null ? int.parse(goalId!) : null;

        await Provider.of<HomeProvider>(context, listen: false).updateGoal(
          intGoalId,
          name,
          color,
        );

        if (!context.mounted) return;

        await Provider.of<ScheduleProvider>(context, listen: false).getGoals();
      },
    );
  }
}
