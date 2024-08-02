import 'package:flutter/material.dart';
import 'package:mandalart/model/detailed_plan_model.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/plan_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/home/plan_bottom_sheet.dart';
import 'package:provider/provider.dart';

class DetailedEmptyWidget extends StatelessWidget {
  final String? mode;
  final String? type;
  final DetailedPlanModel? detailedPlan;
  final double? size;

  const DetailedEmptyWidget({
    super.key,
    this.mode,
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
            isScrollControlled: true,
            backgroundColor: ColorClass.white,
            builder: (BuildContext context) {
              return PlanBottomSheet(
                type: 'detailedPlan',
                planId: detailedPlan?.planId,
                detailedPlanId: detailedPlan?.id,
                create: (String name, Color color) async {
                  if (mode == "maximize") {
                    await Provider.of<HomeProvider>(context, listen: false)
                        .upsertMandalDetailedPlan(
                      detailedPlan?.planId,
                      detailedPlan?.id,
                      name,
                      color,
                    );
                  } else {
                    await Provider.of<PlanProvider>(context, listen: false)
                        .upsertMandalDetailedPlan(
                      detailedPlan?.planId,
                      detailedPlan?.id,
                      name,
                      color,
                    );
                  }
                },
              );
            },
          );
        },
        child: Container(
          width: size ?? double.infinity,
          margin: const EdgeInsets.all(3),
          decoration: type == 'plan'
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
            size: type == 'plan' ? 20 : 10,
            color: ColorClass.gray,
          ),
        ),
      ),
    );
  }
}
