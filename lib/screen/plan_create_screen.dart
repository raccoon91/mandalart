import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/mandal_model.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/base/layout.dart';
import 'package:mandalart/widget/home/plan_widget.dart';
import 'package:provider/provider.dart';

class PlanCreateScreen extends StatefulWidget {
  final String? projectId;
  final String? planId;

  const PlanCreateScreen({
    super.key,
    required this.projectId,
    required this.planId,
  });

  @override
  State<PlanCreateScreen> createState() => _PlanCreateScreenState();
}

class _PlanCreateScreenState extends State<PlanCreateScreen> {
  final planController = TextEditingController();
  Color color = ColorClass.skyBlue;
  bool enabled = false;

  colorTapped(Color color) {
    this.color = color;
    setState(() {});
  }

  nameChanged(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }
    setState(() {});
  }

  createTapped() async {
    await Provider.of<HomeProvider>(context, listen: false).upsertMandalPlan(
      widget.projectId != null ? int.parse(widget.projectId!) : null,
      widget.planId != null ? int.parse(widget.planId!) : null,
      planController.text,
      color,
    );

    if (!mounted) return;

    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    MandalModel mandal = MandalModel.fromJson(
      'plan',
      {
        "id": 0,
        "name": planController.text,
        "color": color,
      },
    );

    return Layout(
      title: "계획",
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorPicker(color: color, onTapped: colorTapped),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Flexible(
                  flex: 1,
                  child: SizedBox(),
                ),
                Flexible(
                  flex: 1,
                  child: PlanWidget(
                    mandal: mandal,
                  ),
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Input(
              autofocus: true,
              placeholder: "계획을 입력하세요",
              controller: planController,
              onChanged: nameChanged,
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: Button(
                text: "계획 만들기",
                onPressed: enabled ? createTapped : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
