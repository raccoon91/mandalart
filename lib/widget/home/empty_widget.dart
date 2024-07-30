import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

class EmptyWidget extends StatefulWidget {
  final int? projectId;
  final int? planId;
  final double? size;

  const EmptyWidget({
    super.key,
    this.projectId,
    this.planId,
    this.size,
  });

  @override
  State<EmptyWidget> createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  goToPlanCreateScreen() {
    if (widget.projectId == null) return;

    String? projectIdPathParam = 'projectId=${widget.projectId}';
    String? planIdPathParam =
        widget.planId != null ? 'planId=${widget.planId}' : "";

    context.push("/main-target/create?$projectIdPathParam&$planIdPathParam");
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: goToPlanCreateScreen,
        child: Container(
          width: widget.size ?? double.infinity,
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: ColorClass.under,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Icon(
            Icons.add,
            size: 20,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
