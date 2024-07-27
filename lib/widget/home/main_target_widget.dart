import 'package:flutter/material.dart';
import 'package:mandalart/model/main_target_model.dart';

class MainTargetWidget extends StatelessWidget {
  final MainTargetModel mainTarget;
  final Color? color;

  const MainTargetWidget({
    super.key,
    required this.mainTarget,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(mainTarget.name),
        ),
      ),
    );
  }
}
