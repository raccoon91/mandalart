import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/goal_template_model.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/template_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/toggle_button.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';

class GoalTemplateSelectScreen extends StatefulWidget {
  final String? goalId;

  const GoalTemplateSelectScreen({
    super.key,
    this.goalId,
  });

  @override
  State<GoalTemplateSelectScreen> createState() => _GoalTemplateSelectScreenState();
}

class _GoalTemplateSelectScreenState extends State<GoalTemplateSelectScreen> {
  GoalTemplateModel? defaultGoalTemplate;

  @override
  void initState() {
    super.initState();

    getGoalTemplateSelectScreenData();
  }

  void getGoalTemplateSelectScreenData() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);

    await Provider.of<TemplateProvider>(context, listen: false).getGoalTemplates(goalId: goalId);

    if (!mounted) return;

    defaultGoalTemplate = Provider.of<TemplateProvider>(context, listen: false).selectedGoalTemplate;
  }

  void changeGoalTemplate(GoalTemplateModel goalTemplate) {
    Provider.of<TemplateProvider>(context, listen: false).selectGoalTemplate(goalTemplate: goalTemplate);
  }

  Future<void> removeGoal() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var selectedGoalTemplate = Provider.of<TemplateProvider>(context, listen: false).selectedGoalTemplate;

    if (goalId == null || selectedGoalTemplate == null) return;

    await Provider.of<HomeProvider>(context, listen: false).removeGoal(goalId: goalId);

    if (!mounted) return;

    GoRouter.of(context).go('/home');
  }

  Future<void> submitGoal() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var selectedGoalTemplate = Provider.of<TemplateProvider>(context, listen: false).selectedGoalTemplate;

    if (goalId == null || selectedGoalTemplate == null) return;

    await Provider.of<HomeProvider>(context, listen: false).updateGoal(
      goalId: goalId,
      goalTemplateId: selectedGoalTemplate.id,
    );

    if (!mounted) return;

    Provider.of<HomeProvider>(context, listen: false).getGoal(goalId: goalId);

    GoRouter.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '목표 선택',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, right: 20.w, bottom: 10.h, left: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('목표', style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: ColorClass.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/template/goal/create');
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('목표 추가', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<TemplateProvider>(
              builder: (context, state, child) {
                return ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: state.goalTemplates.length,
                  itemBuilder: (context, index) {
                    var goalTemplate = state.goalTemplates[index];

                    return ToggleButton(
                      text: goalTemplate.name ?? '',
                      color: goalTemplate.color,
                      selected: Provider.of<TemplateProvider>(context).selectedGoalTemplate?.id == goalTemplate.id,
                      right: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          GoRouter.of(context).push('/template/goal/${goalTemplate.id}');
                        },
                        child: Icon(Icons.edit_rounded, size: 24.w),
                      ),
                      onPressed: () {
                        changeGoalTemplate(goalTemplate);
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
          defaultGoalTemplate == null
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                  ),
                  onPressed: Provider.of<TemplateProvider>(context).selectedGoalTemplate != null ? submitGoal : null,
                  child: Text(
                    '목표 선택완료',
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
                          onTap: removeGoal,
                          child: Column(
                            children: [
                              const Icon(Icons.remove_circle_outline_rounded),
                              SizedBox(height: 8.w),
                              Text(
                                '사용 안 함',
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: submitGoal,
                          child: Column(
                            children: [
                              const Icon(Icons.check_circle_outline_rounded),
                              SizedBox(height: 8.w),
                              Text(
                                '선택 완료',
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
