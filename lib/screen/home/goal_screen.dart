import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
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
      getGoal();
    });
  }

  Future<void> getGoal() async {
    int? goalId = widget.goalId != null ? int.parse(widget.goalId!) : null;

    await Provider.of<HomeProvider>(context, listen: false).getGoal(goalId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorClass.white,
      child: Consumer<HomeProvider>(
        builder: (context, state, child) => MandalLayout(
          isEmpty: state.goal == null ||
              state.plans == null ||
              state.plans?.isEmpty == true,
          emptyMessage: '계획을 설정하세요',
          title: MandalTitle(
            showClose: true,
            visionName: state.visionName,
            goalName: state.goal?.name,
          ),
          body: PlanMandalartWidget(
            route: 'goal',
            goal: state.goal,
          ),
        ),
      ),
    );
  }
}
