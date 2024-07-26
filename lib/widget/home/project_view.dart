import 'package:flutter/material.dart';
import 'package:mandalart/widget/home/project_create.dart';
import 'package:mandalart/widget/home/project_start.dart';

const int defaultPageIndex = 0;

class ProjectView extends StatefulWidget {
  const ProjectView({
    super.key,
  });

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  int bottomNavigationIndex = defaultPageIndex;

  PageController pageController = PageController(
    initialPage: defaultPageIndex,
    keepPage: true,
  );

  void pageChanged(int index) {
    setState(() {
      bottomNavigationIndex = index;
    });
  }

  void moveToCreate() {
    setState(() {
      bottomNavigationIndex = 1;
      pageController.animateToPage(
        1,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      onPageChanged: pageChanged,
      children: [
        ProjectStart(moveToCreate: moveToCreate),
        const ProjectCreate(),
      ],
    );
  }
}
