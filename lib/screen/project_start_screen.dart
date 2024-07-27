import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/widget/base/button.dart';

class ProjectStartScreen extends StatefulWidget {
  const ProjectStartScreen({super.key});

  @override
  State<ProjectStartScreen> createState() => _ProjectStartScreenState();
}

class _ProjectStartScreenState extends State<ProjectStartScreen> {
  startTapped() {
    context.push("/project/create");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("목표 설정"),
      ),
      body: Center(
        child: Button(
          text: "Start Project",
          onPressed: startTapped,
        ),
      ),
    );
  }
}
