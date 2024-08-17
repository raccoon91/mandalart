import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/home/mandal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class GoalBottomSheetScreen extends StatelessWidget {
  final String? goalId;

  const GoalBottomSheetScreen({
    super.key,
    this.goalId,
  });

  @override
  Widget build(BuildContext context) {
    return MandalBottomSheet(
      type: 'goal',
      goalId: goalId != null ? int.parse(goalId!) : null,
      create: (String name, Color color) async {
        await Provider.of<HomeProvider>(context, listen: false).updateGoal(
          goalId != null ? int.parse(goalId!) : null,
          name,
          color,
        );

        if (!context.mounted) return;

        Provider.of<ScheduleProvider>(context, listen: false).getGoals();
      },
    );
  }
}
