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
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(
                title!,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              centerTitle: true,
              backgroundColor: ColorClass.under,
            )
          : null,
      backgroundColor: ColorClass.white,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: padding,
        child: body,
      ),
    );
  }
}
