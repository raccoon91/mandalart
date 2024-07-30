import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/empty_plan_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class MandalWidget extends StatefulWidget {
  final String type;
  final ProjectModel? project;
  final dynamic data;

  const MandalWidget({
    super.key,
    required this.type,
    this.project,
    this.data,
  });

  @override
  State<MandalWidget> createState() => _MandalWidgetState();
}

class _MandalWidgetState extends State<MandalWidget> {
  goToPlanCreateScreen() {
    if (widget.type == "project" || widget.project?.id == null) return;

    String? projectIdPathParam = 'projectId=${widget.project!.id}';
    String? planIdPathParam =
        widget.data.id != null ? 'planId=${widget.data.id}' : "";

    context.push("/main-target/create?$projectIdPathParam&$planIdPathParam");
  }

  @override
  Widget build(BuildContext context) {
    MandalModel? mandal = widget.data == null
        ? null
        : MandalModel.fromSchema(
            widget.type,
            widget.data,
          );

    if (mandal == null || mandal.name == null) {
      return Flexible(
        child: EmptyPlanWidget(onTap: goToPlanCreateScreen),
      );
    }

    return Flexible(
      child: PlanWidget(mandal: mandal),
    );
  }
}
