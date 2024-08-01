import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/plan_bottom_sheet.dart';

class EmptyWidget extends StatelessWidget {
  final int? planId;
  final double? size;

  const EmptyWidget({
    super.key,
    this.planId,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            useRootNavigator: true,
            backgroundColor: ColorClass.white,
            builder: (BuildContext context) {
              return PlanBottomSheet(
                type: 'plan',
                planId: planId,
              );
            },
          );
        },
        child: Container(
          width: size ?? double.infinity,
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
