import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class MandalartView extends StatefulWidget {
  final ProjectModel? project;

  const MandalartView({
    super.key,
    this.project,
  });

  @override
  State<MandalartView> createState() => _MandalartViewState();
}

class _MandalartViewState extends State<MandalartView> {
  goToPlanCreateScreen(int? planId) {
    return () {
      if (widget.project?.id == null) return;

      String? projectIdPathParam =
          widget.project?.id != null ? 'projectId=${widget.project?.id}' : "";
      String? planIdPathParam = planId != null ? 'planId=$planId' : "";

      context.push(
        "/main-target/create?$projectIdPathParam&$planIdPathParam",
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              plan: widget.project?.plans?[index],
            );
          }),
        ),
        Row(
          children: [
            PlanWidget(
              plan: widget.project?.plans?[3],
            ),
            Flexible(
              child: CardWidget(
                size: double.infinity,
                name: widget.project?.name,
                color: widget.project?.color,
              ),
            ),
            PlanWidget(
              plan: widget.project?.plans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              plan: widget.project?.plans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
