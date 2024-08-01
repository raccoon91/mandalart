import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/detailed_empty_widget.dart';

class DetailedPlanWidget extends StatelessWidget {
  final DetailedPlanModel? detailedPlan;

  const DetailedPlanWidget({
    super.key,
    this.detailedPlan,
  });

  @override
  Widget build(BuildContext context) {
    if (detailedPlan == null || detailedPlan?.name == null) {
      return Flexible(
        child: DetailedEmptyWidget(detailedPlan: detailedPlan),
      );
    }

    return Flexible(
      child: CardWidget(
        name: detailedPlan?.name,
        color: detailedPlan?.color,
      ),
    );
  }
}
