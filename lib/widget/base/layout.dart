import 'package:flutter/material.dart';
import 'package:mandalart/theme/color.dart';

class Layout extends StatelessWidget {
  final String? title;
  final Widget body;
  final Widget? bottomNavigationBar;

  const Layout({
    super.key,
    this.title,
    required this.body,
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              centerTitle: true,
              backgroundColor: ColorClass.white,
              title: Text(
                title ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
      backgroundColor: ColorClass.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: body,
        ),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
