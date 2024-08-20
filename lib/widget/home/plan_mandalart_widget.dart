import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/goal_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_empty_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class PlanMandalartWidget extends StatelessWidget {
  final String? mode;
  final String type;
  final GoalModel? goal;

  const PlanMandalartWidget({
    super.key,
    this.mode,
    required this.type,
    this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              mode: mode,
              type: type,
              goalId: goal?.id,
              plan: goal?.plans?[index],
            );
          }),
        ),
        Row(
          children: [
            PlanWidget(
              mode: mode,
              type: type,
              goalId: goal?.id,
              plan: goal?.plans?[3],
            ),
            goal?.name == null
                ? Flexible(child: PlanEmptyWidget(type: type))
                : Flexible(
                    child: CardWidget(
                      name: type == 'goal' ? goal?.name : null,
                      color: goal?.color,
                      onTap: () {
                        if (goal?.id == null) return;

                        if (type == 'goal') {
                          context.push('/sheet/goal/update/${goal?.id}');
                        } else if (type == 'plan') {
                          context.push('/home/goal/${goal?.id}');
                        }
                      },
                    ),
                  ),
            PlanWidget(
              mode: mode,
              type: type,
              goalId: goal?.id,
              plan: goal?.plans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              mode: mode,
              type: type,
              goalId: goal?.id,
              plan: goal?.plans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
