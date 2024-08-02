import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/detailed_empty_widget.dart';
import 'package:mandalart/widget/home/detailed_plan_widget.dart';

class DetailedMandalartWidget extends StatelessWidget {
  final String type;
  final PlanModel? plan;

  const DetailedMandalartWidget({
    super.key,
    required this.type,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return DetailedPlanWidget(
              type: type,
              detailedPlan: plan?.detailedPlans?[index],
            );
          }),
        ),
        Row(
          children: [
            DetailedPlanWidget(
              type: type,
              detailedPlan: plan?.detailedPlans?[3],
            ),
            plan?.name == null
                ? Flexible(
                    child: DetailedEmptyWidget(
                      type: type,
                    ),
                  )
                : Flexible(
                    child: CardWidget(
                      name: type == 'plan' ? plan?.name : null,
                      color: plan?.color,
                      size: double.infinity,
                    ),
                  ),
            DetailedPlanWidget(
              type: type,
              detailedPlan: plan?.detailedPlans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return DetailedPlanWidget(
              type: type,
              detailedPlan: plan?.detailedPlans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
