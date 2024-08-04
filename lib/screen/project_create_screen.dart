import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/home/card_widget.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';
import 'package:provider/provider.dart';

class ProjectCreateScreen extends StatefulWidget {
  const ProjectCreateScreen({super.key});

  @override
  State<ProjectCreateScreen> createState() => _ProjectCreateScreenState();
}

class _ProjectCreateScreenState extends State<ProjectCreateScreen> {
  final projectController = TextEditingController();
  Color color = ColorClass.red;
  bool enabled = false;

  colorTapped(Color color) {
    this.color = color;
    setState(() {});
  }

  projectChanged(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }
    setState(() {});
  }

  createTapped() async {
    if (projectController.text.isEmpty) return;

    await Provider.of<HomeProvider>(context, listen: false).createMandalProject(
      projectController.text,
      color,
    );

    if (!mounted) return;

    context.go('/home');
  }

  submitted(String name) async {
    if (name.isEmpty) return;

    await Provider.of<HomeProvider>(context, listen: false).createMandalProject(
      name,
      color,
    );

    if (!mounted) return;

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: '목표',
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Flexible(
                          flex: 1,
                          child: CardWidget(
                            name: projectController.text,
                            color: color,
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    ColorPicker(color: color, onTapped: colorTapped),
                    SizedBox(height: 40.h),
                    Input(
                      autofocus: true,
                      placeholder: '목표를 입력하세요',
                      controller: projectController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onChanged: projectChanged,
                      onSubmitted: enabled ? submitted : null,
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 60.h,
              child: Button(
                text: '시작하기',
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
