import 'package:flutter/material.dart';
import 'package:mandalart/model/mandal_model.dart';

class PlanWidget extends StatelessWidget {
  final MandalModel mandal;
  final double? size;

  const PlanWidget({
    super.key,
    required this.mandal,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: size ?? double.infinity,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mandal.color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            mandal.name ?? "",
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
