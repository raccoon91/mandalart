import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/empty_widget.dart';

class PlanWidget extends StatefulWidget {
  final PlanModel? plan;

  const PlanWidget({
    super.key,
    this.plan,
  });

  @override
  State<PlanWidget> createState() => _PlanWidgetState();
}

class _PlanWidgetState extends State<PlanWidget> {
  goToPlanCreateScreen() {
    if (widget.plan?.projectId == null) return;

    String? projectIdPathParam = 'projectId=${widget.plan?.projectId}';
    String? planIdPathParam =
        widget.plan?.id != null ? 'planId=${widget.plan!.id}' : "";

    context.push("/main-target/create?$projectIdPathParam&$planIdPathParam");
  }

  @override
  Widget build(BuildContext context) {
    if (widget.plan == null || widget.plan?.name == null) {
      return Flexible(
        child: EmptyWidget(onTap: goToPlanCreateScreen),
      );
    }

    return Flexible(
      child: CardWidget(
        name: widget.plan?.name,
        color: widget.plan?.color,
      ),
    );
  }
}
