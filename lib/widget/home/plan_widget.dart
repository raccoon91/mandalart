import 'package:flutter/material.dart';
import 'package:mandalart/model/mandal_model.dart';

class PlanWidget extends StatelessWidget {
  final MandalModel mandal;

  const PlanWidget({
    super.key,
    required this.mandal,
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
      ),
    );
  }
}
