import 'package:flutter/material.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/floating_button.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  final String? title;
  final bool showFloatingAction;
  final Widget? bottomNavigationBar;
  final Widget body;

  const ScreenLayout({
    super.key,
    this.title,
    required this.body,
    this.showFloatingAction = false,
    this.bottomNavigationBar,
  });

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  modeTapped() {
    Provider.of<HomeProvider>(
      context,
      listen: false,
    ).changeMode();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.title == null
            ? null
            : AppBar(
                centerTitle: true,
                backgroundColor: ColorClass.white,
                surfaceTintColor: ColorClass.white,
                title: Text(
                  widget.title ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
        backgroundColor: ColorClass.white,
        body: widget.body,
        floatingActionButton: FloatingButton(
          show: widget.showFloatingAction,
          onPressed: modeTapped,
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }
}
