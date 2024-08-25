import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/goal_empty_widget.dart';
import 'package:mandalart/widget/home/plan_mandalart_widget.dart';

class GoalWidget extends StatelessWidget {
  final String mode;
  final GoalModel? goal;

  const GoalWidget({
    super.key,
    required this.mode,
    this.goal,
  });

  @override
  Widget build(BuildContext context) {
    if (goal == null || goal?.name == null) {
      return Flexible(
        child: GoalEmptyWidget(
          mode: mode,
          goalId: goal?.id,
        ),
      );
    }

    if (mode == 'maximize') {
      return Flexible(
        child: PlanMandalartWidget(
          route: 'home',
          mode: mode,
          goal: goal,
        ),
      );
    }

    return Flexible(
      child: CardWidget(
        name: goal?.name,
        color: goal?.color,
        onTap: () {
          if (goal?.id == null) return;

          context.push('/home/goal/${goal?.id}');
        },
      ),
    );
  }
}
