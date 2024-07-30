import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/mandal_widget.dart';

class MandalartView extends StatefulWidget {
  final ProjectModel? project;
  final List<PlanModel?>? plans;

  const MandalartView({
    super.key,
    this.project,
    this.plans,
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
            return MandalWidget(
              type: "plan",
              project: widget.project,
              data: widget.plans?[index],
            );
          }),
        ),
        Row(
          children: [
            MandalWidget(
              type: "plan",
              project: widget.project,
              data: widget.plans?[3],
            ),
            MandalWidget(
              type: "project",
              data: widget.project,
            ),
            MandalWidget(
              type: "plan",
              project: widget.project,
              data: widget.plans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return MandalWidget(
              type: "plan",
              project: widget.project,
              data: widget.plans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
