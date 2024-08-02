import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/plan_bottom_sheet.dart';

class DetailedEmptyWidget extends StatelessWidget {
  final String? type;
  final DetailedPlanModel? detailedPlan;
  final double? size;

  const DetailedEmptyWidget({
    super.key,
    this.type,
    this.detailedPlan,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            backgroundColor: ColorClass.white,
            builder: (BuildContext context) {
              return PlanBottomSheet(
                type: 'detailedPlan',
                planId: detailedPlan?.planId,
                detailedPlanId: detailedPlan?.id,
              );
            },
          );
        },
        child: Container(
          width: size ?? double.infinity,
          margin: const EdgeInsets.all(3),
          decoration: type == "plan"
              ? BoxDecoration(
                  color: ColorClass.under,
                  borderRadius: BorderRadius.circular(4),
                )
              : BoxDecoration(
                  border: Border.all(color: ColorClass.under),
                  borderRadius: BorderRadius.circular(4),
                ),
          child: Icon(
            Icons.add,
            size: type == "plan" ? 20 : 10,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
