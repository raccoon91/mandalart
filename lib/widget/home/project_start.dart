import 'package:flutter/material.dart';
import 'package:mandalart/widget/base/button.dart';

class ProjectStart extends StatelessWidget {
  final void Function() moveToCreate;

  const ProjectStart({
    super.key,
    required this.moveToCreate,
  });

  startTapped() {
    moveToCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        text: "Start Project",
        onPressed: startTapped,
      ),
    );
  }
}
