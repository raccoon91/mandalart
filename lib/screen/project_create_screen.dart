import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/color_picker.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:mandalart/widget/base/layout.dart';
import 'package:mandalart/widget/home/card_widget.dart';
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
    await Provider.of<HomeProvider>(context, listen: false).createMandalProject(
      projectController.text,
      color,
    );

    if (!mounted) return;

    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: '목표',
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
                  const SizedBox(height: 30),
                  ColorPicker(color: color, onTapped: colorTapped),
                  const SizedBox(height: 30),
                  Input(
                    autofocus: true,
                    placeholder: '목표를 입력하세요',
                    controller: projectController,
                    onChanged: projectChanged,
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
              text: '시작하기',
              onPressed: enabled ? createTapped : null,
            ),
          ),
        ],
      ),
    );
  }
}
