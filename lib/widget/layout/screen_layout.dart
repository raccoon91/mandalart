import 'package:flutter/material.dart';

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
      appBar: title != null ? AppBar(title: Text(title!)) : null,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: Container(
        padding: padding,
        child: body,
      ),
    );
  }
}
