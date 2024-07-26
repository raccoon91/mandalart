import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/base/input.dart';
import 'package:provider/provider.dart';

class ProjectCreate extends StatefulWidget {
  const ProjectCreate({super.key});

  @override
  State<ProjectCreate> createState() => _ProjectCreateState();
}

class _ProjectCreateState extends State<ProjectCreate> {
  final projectController = TextEditingController();
  bool enabled = false;

  createProjectTapped() async {
    Provider.of<HomeProvider>(
      context,
      listen: false,
    ).createProject(
      projectController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Input(
            autofocus: true,
            controller: projectController,
            onChanged: (data) {
              if (projectController.text.isEmpty) {
                enabled = false;
              } else {
                enabled = true;
              }

              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          Button(
            text: "Create Project",
            onPressed: enabled ? createProjectTapped : null,
          ),
        ],
      ),
    );
  }
}
