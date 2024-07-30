import 'package:flutter/material.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class MandalartWidget extends StatefulWidget {
  final String mode;
  final ProjectModel? project;

  const MandalartWidget({
    super.key,
    required this.mode,
    this.project,
  });

  @override
  State<MandalartWidget> createState() => _MandalartWidgetState();
}

class _MandalartWidgetState extends State<MandalartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              mode: widget.mode,
              plan: widget.project?.plans?[index],
            );
          }),
        ),
        Row(
          children: [
            PlanWidget(
              mode: widget.mode,
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
              mode: widget.mode,
              plan: widget.project?.plans?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return PlanWidget(
              mode: widget.mode,
              plan: widget.project?.plans?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
