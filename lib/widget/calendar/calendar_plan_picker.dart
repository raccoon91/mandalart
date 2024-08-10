import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:provider/provider.dart';

class CalendarPlanPicker extends StatelessWidget {
  final int? selectedPlanId;
  final void Function(int planId)? onChanged;

  const CalendarPlanPicker({
    super.key,
    this.selectedPlanId,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 40.w,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.playlist_add),
                SizedBox(width: 10.w),
                Text(
                  '계획',
                  style: TextStyle(fontSize: 20.sp),
                )
              ],
            ),
            SizedBox(height: 10.h),
            Consumer<CalendarProvider>(
              builder: (context, state, child) => state.isEmpty
                  ? const Text('계획을 설정하세요')
                  : LayoutBuilder(
                      builder: (context, constraints) => SizedBox(
                        width: constraints.maxWidth,
                        child: Wrap(
                          spacing: 10.w,
                          runSpacing: 10.w,
                          children: state.plans
                                  ?.map(
                                    (plan) => GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        if (plan?.id == null ||
                                            onChanged == null) {
                                          return;
                                        }

                                        onChanged!(plan!.id);
                                      },
                                      child: Container(
                                        width:
                                            (constraints.maxWidth - 22.w) / 2,
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.h,
                                          horizontal: 16.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: selectedPlanId == plan?.id
                                              ? plan?.color
                                              : ColorClass.white,
                                          border: Border.all(
                                            color: selectedPlanId == plan?.id
                                                ? plan?.color ?? ColorClass.gray
                                                : ColorClass.gray,
                                          ),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(4.r),
                                          ),
                                        ),
                                        child: Text(
                                          plan?.name ?? '',
                                          style: TextStyle(
                                            color: selectedPlanId == plan?.id
                                                ? ColorClass.black
                                                : ColorClass.gray,
                                            fontSize: 18.sp,
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
      ),
    );
  }
}
