import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_empty_widget.dart';

class PlanWidget extends StatelessWidget {
  final String? mode;
  final String type;
  final int? goalId;
  final PlanModel? plan;

  const PlanWidget({
    super.key,
    this.mode,
    required this.type,
    this.goalId,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    if (plan == null || plan?.name == null) {
      return Flexible(
        child: PlanEmptyWidget(
          mode: mode,
          type: type,
          plan: plan,
        ),
      );
    }

    return Flexible(
      child: CardWidget(
        name: (mode == 'minimize' || type == 'plan') ? null : plan?.name,
        color: plan?.color,
        onTap: () {
          if (plan?.id == null) return;

          if ((mode == 'maximize' && type == 'plan') || type == 'goal') {
            context.push('/sheet/plan/update/$goalId/${plan?.id}');
          }
        },
      ),
    );
  }
}
