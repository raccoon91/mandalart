import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class ScreenLayout extends StatelessWidget {
  final String? title;
  final Widget body;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;

  const ScreenLayout({
    super.key,
    this.title,
    required this.body,
    this.padding,
    this.bottomNavigationBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: padding,
        child: Scaffold(
          backgroundColor: ColorClass.white,
          bottomNavigationBar: bottomNavigationBar,
          body: body,
        ),
      ),
    );
  }
}
