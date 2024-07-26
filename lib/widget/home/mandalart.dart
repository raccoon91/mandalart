import 'package:flutter/material.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/widget/home/empty_target_widget.dart';
import 'package:mandalart/widget/home/main_target_widget.dart';
import 'package:mandalart/widget/home/project_widget.dart';

class Mandalart extends StatelessWidget {
  final ProjectModel? project;

  const Mandalart({
    super.key,
    this.project,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (rowIndex) {
        return Row(
          children: List.generate(3, (columnIndex) {
            int index = (3 * rowIndex) + columnIndex;
            bool isEmpty = project == null ||
                project?.mainTargets == null ||
                project!.mainTargets!.isEmpty ||
                project?.mainTargets?[index] == null;

            if (index == 4) return ProjectWidget(project: project!);

            if (isEmpty) return const EmptyTargetWidget();

            return MainTargetWidget(mainTarget: project!.mainTargets![index]);
          }),
        );
      }),
    );
  }
}
