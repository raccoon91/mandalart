import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/base/layout.dart';
import 'package:mandalart/widget/home/card_widget.dart';
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
  PlanModel? nextPlan;
  bool enabled = false;
  bool nextEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  colorTapped(Color color) {
    this.color = color;
    setState(() {});
  }

  planChanged(String data) {
    if (data.isEmpty) {
      enabled = false;
    } else {
      enabled = true;
    }
    setState(() {});
  }

  createTapped() async {
    if (widget.projectId == null) return;

    await Provider.of<HomeProvider>(context, listen: false).upsertMandalPlan(
      widget.planId,
      planController.text,
      color,
    );

    if (!mounted) return;

    context.go("/");
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: "계획",
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
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
                          name: planController.text,
                          color: color,
                        ),
                      ),
                      const Flexible(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ColorPicker(color: color, onTapped: colorTapped),
                  const SizedBox(height: 30),
                  Input(
                    autofocus: true,
                    placeholder: "계획을 입력하세요",
                    controller: planController,
                    onChanged: planChanged,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Button(
              text: "만들기",
              onPressed: enabled ? createTapped : null,
            ),
          ),
        ],
      ),
    );
  }
}
