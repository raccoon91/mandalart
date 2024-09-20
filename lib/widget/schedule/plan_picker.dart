import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/schedule_provider.dart';
import 'package:mandalart/widget/schedule/schedule_picker_widget.dart';
import 'package:provider/provider.dart';

class PlanPicker extends StatelessWidget {
  final int? selectedPlanId;
  final void Function(int planId)? onChanged;

  const PlanPicker({
    super.key,
    this.selectedPlanId,
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
          Consumer<ScheduleProvider>(builder: (context, state, child) {
            if (state.plans == null || state.plans?.isEmpty == true) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Text(
                  '상세 계획을 설정하세요',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              );
            }

            return LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 10.w,
                  children: state.plans?.map((plan) {
                        return SchedulePickerWidget(
                          id: plan?.id,
                          name: plan?.name,
                          color: plan?.color,
                          width: (constraints.maxWidth - 22.w) / 2,
                          selected: selectedPlanId == plan?.id,
                          onTap: () {
                            if (plan?.id == null || onChanged == null) return;

                            onChanged!(plan!.id);
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
