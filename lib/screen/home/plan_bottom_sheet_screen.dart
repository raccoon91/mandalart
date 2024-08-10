import 'package:flutter/material.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/home/plan_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PlanBottomSheetScreen extends StatelessWidget {
  final String? planId;

  const PlanBottomSheetScreen({
    super.key,
    this.planId,
  });

  @override
  Widget build(BuildContext context) {
    return PlanBottomSheet(
      type: 'plan',
      planId: planId != null ? int.parse(planId!) : null,
      create: (String name, Color color) async {
        await Provider.of<HomeProvider>(
          context,
          listen: false,
        ).upsertMandalPlan(
          planId != null ? int.parse(planId!) : null,
          name,
          color,
        );

        if (!context.mounted) return;

        Provider.of<CalendarProvider>(context, listen: false).getPlans();
      },
    );
  }
}
