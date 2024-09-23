import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/template_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';

class PlanTemplateDetailScreen extends StatefulWidget {
  final String? goalId;
  final String? planTemplateId;

  const PlanTemplateDetailScreen({
    super.key,
    this.goalId,
    this.planTemplateId,
  });

  @override
  State<PlanTemplateDetailScreen> createState() => _PlanTemplateDetailScreenState();
}

class _PlanTemplateDetailScreenState extends State<PlanTemplateDetailScreen> {
  final nameController = TextEditingController();
  Color color = ColorClass.blue;
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    getPlanTemplateDetailScreenData();
  }

  Future<void> getPlanTemplateDetailScreenData() async {
    if (widget.planTemplateId == null || widget.planTemplateId == 'create') return;

    var planTemplate = await Provider.of<TemplateProvider>(context, listen: false).getPlanTemplate(
      planTemplateId: int.parse(widget.planTemplateId!),
    );

    if (planTemplate == null) return;

    nameController.text = planTemplate.name ?? '';
    color = planTemplate.color ?? ColorClass.blue;

    setState(() {});
  }

  changeColor(Color color) {
    this.color = color;

    if (nameController.text.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }

    setState(() {});
  }

  changePlanTemplateName(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }

    setState(() {});
  }

  submitPlanTemplate(String name) async {
    if (name.isEmpty) return;

    var goalId = widget.goalId == null ? null : int.parse(widget.goalId!);
    var planTemplateId = widget.planTemplateId == 'create' ? null : int.parse(widget.planTemplateId!);

    await Provider.of<TemplateProvider>(context, listen: false).upsertPlanTemplate(
      goalId: goalId,
      planTemplateId: planTemplateId,
      name: name,
      color: color,
    );

    if (!mounted) return;

    Provider.of<TemplateProvider>(context, listen: false).getPlanTemplates(goalId: goalId);

    GoRouter.of(context).pop();
  }

  void clickSubmitPlanTemplate() {
    submitPlanTemplate(nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '계획 추가',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: Container()),
                      Expanded(child: CardWidget(name: nameController.text, color: color)),
                      Expanded(child: Container()),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  ColorPicker(color: color, onTapped: changeColor),
                  SizedBox(height: 30.h),
                  Input(
                    autofocus: true,
                    placeholder: '계획을 입력하세요',
                    controller: nameController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    onChanged: changePlanTemplateName,
                    onSubmitted: enabled ? submitPlanTemplate : null,
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
            ),
            onPressed: enabled ? clickSubmitPlanTemplate : null,
            child: Text(
              widget.planTemplateId == 'create' ? '계획 추가하기' : '계획 수정하기',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
