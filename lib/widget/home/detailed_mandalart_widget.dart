import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/detailed_empty_widget.dart';
import 'package:mandalart/widget/home/detailed_plan_widget.dart';

class DetailedMandalartWidget extends StatelessWidget {
  final PlanModel? plan;

  const DetailedMandalartWidget({
    super.key,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return DetailedPlanWidget(
              detailedPlan: plan?.detailedPlans?[index],
            );
          }),
        ),
        Row(
          children: [
            DetailedPlanWidget(
              detailedPlan: plan?.detailedPlans?[3],
            ),
            plan?.name == null
                ? const Flexible(
                    child: DetailedEmptyWidget(type: "plan"),
                  )
                : Flexible(
                    child: CardWidget(
                      size: double.infinity,
                      color: plan?.color,
                    ),
                  ),
            DetailedPlanWidget(
              detailedPlan: plan?.detailedPlans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return DetailedPlanWidget(
              detailedPlan: plan?.detailedPlans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
