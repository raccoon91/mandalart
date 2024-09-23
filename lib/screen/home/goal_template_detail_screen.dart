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

class GoalTemplateDetailScreen extends StatefulWidget {
  final String? goalTemplateId;

  const GoalTemplateDetailScreen({
    super.key,
    this.goalTemplateId,
  });

  @override
  State<GoalTemplateDetailScreen> createState() => _GoalTemplateDetailScreenState();
}

class _GoalTemplateDetailScreenState extends State<GoalTemplateDetailScreen> {
  final nameController = TextEditingController();
  Color color = ColorClass.blue;
  bool enabled = false;

  @override
  void initState() {
    super.initState();

    getGoalTemplateDetailScreenData();
  }

  Future<void> getGoalTemplateDetailScreenData() async {
    if (widget.goalTemplateId == null || widget.goalTemplateId == 'create') return;

    var goalTemplate = await Provider.of<TemplateProvider>(context, listen: false).getGoalTemplate(
      goalTemplateId: int.parse(widget.goalTemplateId!),
    );

    if (goalTemplate == null) return;

    nameController.text = goalTemplate.name ?? '';
    color = goalTemplate.color ?? ColorClass.blue;

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

  changeGoalTemplateName(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }

    setState(() {});
  }

  submitGoalTemplate(String name) async {
    if (name.isEmpty) return;

    var goalTemplateId = widget.goalTemplateId == 'create' ? null : int.parse(widget.goalTemplateId!);

    await Provider.of<TemplateProvider>(context, listen: false).upsertGoalTemplate(
      goalTemplateId: goalTemplateId,
      name: name,
      color: color,
    );

    if (!mounted) return;

    Provider.of<TemplateProvider>(context, listen: false).getGoalTemplates();

    GoRouter.of(context).pop();
  }

  void clickSubmitGoalTemplate() {
    submitGoalTemplate(nameController.text);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '목표 추가',
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
                    onChanged: changeGoalTemplateName,
                    onSubmitted: enabled ? submitGoalTemplate : null,
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
            onPressed: enabled ? clickSubmitGoalTemplate : null,
            child: Text(
              widget.goalTemplateId == 'create' ? '목표 추가하기' : '목표 수정하기',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
