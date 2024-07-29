import 'package:flutter/material.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/widget/home/empty_plan_widget.dart';
import 'package:mandalart/widget/home/plan_widget.dart';

class MandalWidget extends StatelessWidget {
  final String type;
  final dynamic data;
  final void Function()? onTapEmpty;

  const MandalWidget({
    super.key,
    required this.type,
    this.data,
    this.onTapEmpty,
  });

  @override
  Widget build(BuildContext context) {
    MandalModel? mandal = data == null
        ? null
        : MandalModel.fromSchema(
            type,
            data,
          );

    if (mandal == null || mandal.name == null) {
      return Flexible(
        child: EmptyPlanWidget(onTap: onTapEmpty),
      );
    }

    return Flexible(
      child: PlanWidget(mandal: mandal),
    );
  }
}
