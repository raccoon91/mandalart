import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_empty_widget.dart';

class PlanWidget extends StatelessWidget {
  final String route;
  final String? mode;
  final int? goalId;
  final PlanModel? plan;

  const PlanWidget({
    super.key,
    required this.route,
    this.mode,
    this.goalId,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    if (plan == null || plan?.name == null) {
      return Flexible(
        child: PlanEmptyWidget(
          route: route,
          mode: mode,
          plan: plan,
        ),
      );
    }

    return Flexible(
      child: CardWidget(
        name: (mode == 'minimize' || route == 'home') ? null : plan?.name,
        color: plan?.color,
        onTap: () {
          if (plan?.id == null) return;

          if (((mode == 'maximize' && route == 'home')) || route == 'goal') {
            context.push('/template/goal/$goalId/plan/select/${plan?.id}');
          }
        },
      ),
    );
  }
}
