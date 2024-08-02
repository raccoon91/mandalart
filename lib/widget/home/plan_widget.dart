import 'package:flutter/material.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/detailed_mandalart_widget.dart';
import 'package:mandalart/widget/home/empty_widget.dart';

class PlanWidget extends StatelessWidget {
  final String mode;
  final PlanModel? plan;

  const PlanWidget({
    super.key,
    required this.mode,
    this.plan,
  });

  @override
  Widget build(BuildContext context) {
    if (plan == null || plan?.name == null) {
      return Flexible(
        child: EmptyWidget(planId: plan?.id),
      );
    }

    if (mode == "maximize") {
      return Flexible(
        child: DetailedMandalartWidget(
          plan: plan,
        ),
      );
    }

    return Flexible(
      child: CardWidget(
        name: plan?.name,
        color: plan?.color,
      ),
    );
  }
}
