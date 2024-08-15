import 'package:flutter/material.dart';
import 'package:mandalart/provider/goal_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/home/mandal_title.dart';
import 'package:mandalart/widget/home/plan_mandalart_widget.dart';
import 'package:mandalart/widget/layout/mandal_layout.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  final String? goalId;

  const GoalScreen({
    super.key,
    this.goalId,
  });

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GoalProvider>(
        context,
        listen: false,
      ).getGoal(widget.goalId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeState, child) => Consumer<GoalProvider>(
        builder: (context, goalState, child) => MandalLayout(
          isEmpty: goalState.goal == null ||
              goalState.goal?.plans == null ||
              goalState.goal?.plans?.isEmpty == true,
          emptyMessage: '계획을 설정하세요',
          title: MandalTitle(
            showClose: true,
            visionName: homeState.visionName,
            goalName: goalState.goal?.name,
          ),
          body: PlanMandalartWidget(
            type: 'goal',
            goal: goalState.goal,
          ),
        ),
      ),
    );
  }
}
