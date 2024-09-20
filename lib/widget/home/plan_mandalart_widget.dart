import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_empty_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class PlanMandalartWidget extends StatelessWidget {
  final String route;
  final String? mode;
  final GoalModel? goal;

  const PlanMandalartWidget({
    super.key,
    required this.route,
    this.mode,
    this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              route: route,
              mode: mode,
              goalId: goal?.id,
              plan: goal?.plans?[index],
            );
          }),
        ),
        Row(
          children: [
            PlanWidget(
              route: route,
              mode: mode,
              goalId: goal?.id,
              plan: goal?.plans?[3],
            ),
            goal?.name == null
                ? Flexible(child: PlanEmptyWidget(route: route))
                : Flexible(
                    child: CardWidget(
                      name: route == 'home' ? null : goal?.name,
                      color: goal?.color,
                      onTap: () {
                        if (goal?.id == null) return;

                        if ((mode == 'maximize' && route == 'home') || route == 'goal') {
                          context.push('/template/goal/${goal?.id}');
                        } else {
                          context.push('/home/goal/${goal?.id}');
                        }
                      },
                    ),
                  ),
            PlanWidget(
              route: route,
              mode: mode,
              goalId: goal?.id,
              plan: goal?.plans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              route: route,
              mode: mode,
              goalId: goal?.id,
              plan: goal?.plans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
