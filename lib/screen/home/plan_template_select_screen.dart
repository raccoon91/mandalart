import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_template_model.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/template_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/toggle_button.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';

class PlanTemplateSelectScreen extends StatefulWidget {
  final String? goalId;
  final String? planId;

  const PlanTemplateSelectScreen({
    super.key,
    this.goalId,
    this.planId,
  });

  @override
  State<PlanTemplateSelectScreen> createState() => _PlanTemplateSelectScreenState();
}

class _PlanTemplateSelectScreenState extends State<PlanTemplateSelectScreen> {
  @override
  void initState() {
    super.initState();

    getPlanTemplateSelectScreenData();
  }

  void getPlanTemplateSelectScreenData() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var planId = widget.planId == null ? null : int.parse(widget.planId!);

    Provider.of<TemplateProvider>(context, listen: false).getPlanTemplates(goalId: goalId, planId: planId);
  }

  void changePlanTemplate(PlanTemplateModel planTemplate) {
    Provider.of<TemplateProvider>(context, listen: false).selectPlanTemplate(planTemplate: planTemplate);
  }

  Future<void> removePlan() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var planId = widget.planId == null ? null : int.parse(widget.planId!);
    var selectedPlanTemplate = Provider.of<TemplateProvider>(context, listen: false).selectedPlanTemplate;

    if (goalId == null || selectedPlanTemplate == null) return;

    await Provider.of<HomeProvider>(context, listen: false).removePlan(goalId: goalId, planId: planId);

    if (!mounted) return;

    GoRouter.of(context).pop();
  }

  Future<void> submitPlan() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var planId = widget.planId == null ? null : int.parse(widget.planId!);
    var selectedPlanTemplate = Provider.of<TemplateProvider>(context, listen: false).selectedPlanTemplate;

    if (goalId == null || selectedPlanTemplate == null) return;

    await Provider.of<HomeProvider>(context, listen: false).updatePlan(
      goalId: goalId,
      planId: planId,
      planTemplateId: selectedPlanTemplate.id,
    );

    if (!mounted) return;

    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '계획 선택',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h, right: 30.w, bottom: 10.h, left: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('목표', style: TextStyle(fontSize: 20.sp)),
                SizedBox(height: 20.h),
                ToggleButton(
                  selected: true,
                  onPressed: () {},
                  text: Provider.of<TemplateProvider>(context).selectedGoalTemplate?.name ?? '',
                  color: Provider.of<TemplateProvider>(context).selectedGoalTemplate?.color,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, bottom: 20.h, left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('계획', style: TextStyle(fontSize: 20.sp)),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: ColorClass.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/template/goal/${widget.goalId}/plan/create');
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('계획 추가'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TemplateProvider>(
              builder: (context, state, child) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  itemCount: state.planTemplates.length,
                  itemBuilder: (context, index) {
                    var planTemplate = state.planTemplates[index];

                    return ToggleButton(
                      text: planTemplate.name ?? '',
                      color: planTemplate.color,
                      selected: Provider.of<TemplateProvider>(context).selectedPlanTemplate?.id == planTemplate.id,
                      right: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          GoRouter.of(context).push('/template/goal/${widget.goalId}/plan/${planTemplate.id}');
                        },
                        child: Icon(Icons.edit_rounded, size: 24.w),
                      ),
                      onPressed: () {
                        changePlanTemplate(planTemplate);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 6.h);
                  },
                );
              },
            ),
          ),
          (widget.goalId == null || widget.planId == null)
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                  ),
                  onPressed: Provider.of<TemplateProvider>(context).selectedGoalTemplate != null ? submitPlan : null,
                  child: Text(
                    '계획 선택완료',
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(border: Border(top: BorderSide(color: ColorClass.border, width: 1.h))),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: removePlan,
                          child: Column(
                            children: [
                              const Icon(Icons.remove_circle_outline_rounded),
                              SizedBox(height: 8.w),
                              Text(
                                '계획 제거',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: submitPlan,
                          child: Column(
                            children: [
                              const Icon(Icons.check_circle_outline_rounded),
                              SizedBox(height: 8.w),
                              Text(
                                '선택완료',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
