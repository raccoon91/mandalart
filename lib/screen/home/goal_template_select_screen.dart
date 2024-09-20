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
  @override
  void initState() {
    super.initState();

    getGoalTemplateSelectScreenData();
  }

  void getGoalTemplateSelectScreenData() async {
    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);

    Provider.of<TemplateProvider>(context, listen: false).getGoalTemplates(goalId: goalId);
  }

  void changeGoalTemplate(GoalTemplateModel goalTemplate) {
    Provider.of<TemplateProvider>(context, listen: false).selectGoalTemplate(goalTemplate: goalTemplate);
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

    Provider.of<HomeProvider>(context, listen: false).getVision();

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
            padding: EdgeInsets.only(top: 20.h, right: 30.w, bottom: 10.h, left: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('목표', style: TextStyle(fontSize: 20.sp)),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: ColorClass.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16.w),
                    side: BorderSide.none,
                  ),
                  onPressed: () {
                    GoRouter.of(context).push('/template/goal/create');
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('목표 추가'),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Consumer<TemplateProvider>(
                builder: (context, state, child) {
                  return Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: state.goalTemplates.map((goalTemplate) {
                      return ToggleButton(
                        text: goalTemplate.name ?? '',
                        color: goalTemplate.color,
                        selected: Provider.of<TemplateProvider>(context).selectedGoalTemplate?.id == goalTemplate.id,
                        onPressed: () {
                          changeGoalTemplate(goalTemplate);
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              foregroundColor: ColorClass.black,
              backgroundColor: ColorClass.skyBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            ),
            onPressed: Provider.of<TemplateProvider>(context).selectedGoalTemplate != null ? submitGoal : null,
            child: Text(
              '목표 선택완료',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
