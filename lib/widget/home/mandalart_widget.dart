import 'package:flutter/material.dart';
import 'package:mandalart/model/vision_model.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/home/goal_widget.dart';

class MandalartWidget extends StatefulWidget {
  final String mode;
  final VisionModel? vision;

  const MandalartWidget({
    super.key,
    required this.mode,
    this.vision,
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
            return GoalWidget(
              mode: widget.mode,
              goal: widget.vision?.goals?[index],
            );
          }),
        ),
        Row(
          children: [
            GoalWidget(
              mode: widget.mode,
              goal: widget.vision?.goals?[3],
            ),
            Flexible(
              child: CardWidget(
                name: widget.vision?.name,
                color: widget.vision?.color,
              ),
            ),
            GoalWidget(
              mode: widget.mode,
              goal: widget.vision?.goals?[4],
            ),
          ],
        ),
        Row(
          children: List.generate(3, (index) {
            return GoalWidget(
              mode: widget.mode,
              goal: widget.vision?.goals?[index + 5],
            );
          }),
        ),
      ],
    );
  }
}
