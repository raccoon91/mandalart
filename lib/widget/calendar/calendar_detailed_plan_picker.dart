import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/widget/calendar/calendar_plan_widget.dart';
import 'package:provider/provider.dart';

class CalendarDetailedPlanPicker extends StatelessWidget {
  final int? selectedDetailedPlanId;
  final void Function(int detailedPlanId)? onChanged;

  const CalendarDetailedPlanPicker({
    super.key,
    this.selectedDetailedPlanId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 40.w),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.playlist_add_check),
              SizedBox(width: 10.w),
              Text('상세 계획', style: TextStyle(fontSize: 20.sp))
            ],
          ),
          SizedBox(height: 10.h),
          Consumer<CalendarProvider>(builder: (context, state, child) {
            if (state.detailedPlans == null ||
                state.detailedPlans?.isEmpty == true) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Text(
                  '상세 계획을 설정하세요',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            }

            return LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: state.detailedPlans?.map((detailedPlan) {
                        return CalendarPlanWidget(
                          id: detailedPlan?.id,
                          name: detailedPlan?.name,
                          color: detailedPlan?.color,
                          width: (constraints.maxWidth - 22.w) / 2,
                          selected: selectedDetailedPlanId == detailedPlan?.id,
                          onTap: () {
                            if (detailedPlan?.id == null || onChanged == null) {
                              return;
                            }

                            onChanged!(detailedPlan!.id);
                          },
                        );
                      }).toList() ??
                      [],
                ),
              );
            });
          })
        ],
      ),
    );
  }
}
