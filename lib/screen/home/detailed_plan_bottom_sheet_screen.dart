import 'package:flutter/material.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/plan_provider.dart';
import 'package:mandalart/widget/home/plan_bottom_sheet.dart';
import 'package:provider/provider.dart';

class DetailedPlanBottomSheetScreen extends StatelessWidget {
  final String? mode;
  final String? planId;
  final String? detailedPlanId;

  const DetailedPlanBottomSheetScreen({
    super.key,
    this.mode,
    this.planId,
    this.detailedPlanId,
  });

  @override
  Widget build(BuildContext context) {
    return PlanBottomSheet(
      type: 'detailedPlan',
      planId: detailedPlanId != null ? int.parse(detailedPlanId!) : null,
      detailedPlanId: planId != null ? int.parse(planId!) : null,
      create: (String name, Color color) async {
        if (mode == 'maximize') {
          await Provider.of<HomeProvider>(
            context,
            listen: false,
          ).upsertMandalDetailedPlan(
            planId != null ? int.parse(planId!) : null,
            detailedPlanId != null ? int.parse(detailedPlanId!) : null,
            name,
            color,
          );
        } else {
          await Provider.of<PlanProvider>(
            context,
            listen: false,
          ).upsertMandalDetailedPlan(
            planId != null ? int.parse(planId!) : null,
            detailedPlanId != null ? int.parse(detailedPlanId!) : null,
            name,
            color,
          );

          if (context.mounted) {
            await Provider.of<HomeProvider>(
              context,
              listen: false,
            ).getProjectWithPlans();
          }
        }

        if (!context.mounted) return;

        Provider.of<CalendarProvider>(context, listen: false).getPlans();
      },
    );
  }
}
