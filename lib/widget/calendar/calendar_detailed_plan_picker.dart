import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/theme/color.dart';
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
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 20.w,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.playlist_add_check),
              SizedBox(width: 10.w),
              Text(
                "상세 계획",
                style: TextStyle(fontSize: 18.sp),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Consumer<CalendarProvider>(
            builder: (context, state, child) => state.detailedPlans == null ||
                    state.detailedPlans!.isEmpty
                ? const Text("계획을 설정하세요")
                : LayoutBuilder(
                    builder: (context, constraints) => SizedBox(
                      width: constraints.maxWidth,
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.w,
                        children: state.detailedPlans
                                ?.map(
                                  (detailedPlan) => GestureDetector(
                                    onTap: () {
                                      if (detailedPlan?.id == null ||
                                          onChanged == null) {
                                        return;
                                      }

                                      onChanged!(detailedPlan!.id);
                                    },
                                    child: Container(
                                      width: (constraints.maxWidth - 18.w) / 2,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8.h,
                                        horizontal: 16.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: selectedDetailedPlanId ==
                                                detailedPlan?.id
                                            ? detailedPlan?.color
                                            : ColorClass.white,
                                        border: Border.all(
                                          color: selectedDetailedPlanId ==
                                                  detailedPlan?.id
                                              ? detailedPlan?.color ??
                                                  ColorClass.gray
                                              : ColorClass.gray,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4.r),
                                        ),
                                      ),
                                      child: Text(
                                        detailedPlan?.name ?? "",
                                        style: TextStyle(
                                          color: selectedDetailedPlanId ==
                                                  detailedPlan?.id
                                              ? ColorClass.black
                                              : ColorClass.gray,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
