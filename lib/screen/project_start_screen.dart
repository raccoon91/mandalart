import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/widget/base/button.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';

class ProjectStartScreen extends StatefulWidget {
  const ProjectStartScreen({super.key});

  @override
  State<ProjectStartScreen> createState() => _ProjectStartScreenState();
}

class _ProjectStartScreenState extends State<ProjectStartScreen> {
  startTapped() {
    context.push('/project/create');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      body: Center(
        child: SizedBox(
          height: 60.h,
          child: Button(
            text: '목표 설정하기',
            onPressed: startTapped,
          ),
        ),
      ),
    );
  }
}
