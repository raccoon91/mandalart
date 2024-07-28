import 'package:flutter/material.dart';
import 'package:mandalart/widget/base/layout.dart';

class MainTargetCreateScreen extends StatelessWidget {
  const MainTargetCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Layout(
      title: "목표 생성",
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Center(
          child: Text("create"),
        ),
      ),
    );
  }
}
