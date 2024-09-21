import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

class BottomNavigationLayout extends StatefulWidget {
  final int? branchIndex;
  final StatefulNavigationShell child;

  const BottomNavigationLayout({
    super.key,
    this.branchIndex,
    required this.child,
  });

  @override
  State<BottomNavigationLayout> createState() => _BottomNavigationLayoutState();
}

class _BottomNavigationLayoutState extends State<BottomNavigationLayout> {
  DateTime currentBackPressTime = DateTime.now();
  final Duration requiredSeconds = const Duration(seconds: 2);

  bottomItemTapped(index) {
    if (index == 3) return;

    widget.child.goBranch(index, initialLocation: index == widget.child.currentIndex);
  }

  void onPopInvoked(bool didPop, dynamic result) {
    if (didPop) {
      return;
    }

    DateTime now = DateTime.now();

    if (now.difference(currentBackPressTime) > requiredSeconds) {
      currentBackPressTime = now;

      Fluttertoast.showToast(msg: '한 번 더 누르면 앱이 종료됩니다');

      setState(() {});
    } else {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isHome = widget.branchIndex == 0;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: onPopInvoked,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: isHome ? 100.h : 70.h,
            decoration: BoxDecoration(
              border: isHome ? null : const Border(top: BorderSide(color: ColorClass.border, width: 1)),
              boxShadow: isHome
                  ? [const BoxShadow(color: ColorClass.under, spreadRadius: 3, blurRadius: 7, offset: Offset(0, 3))]
                  : null,
            ),
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              padding: isHome ? EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w) : const EdgeInsets.all(0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(isHome ? Radius.circular(50.r) : const Radius.circular(0)),
                child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: ColorClass.white, primaryColor: ColorClass.primary),
                  child: BottomNavigationBar(
                    currentIndex: widget.child.currentIndex,
                    onTap: bottomItemTapped,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                    items: const [
                      BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home_filled)),
                      BottomNavigationBarItem(label: 'Schedule', icon: Icon(Icons.event_available_rounded)),
                      BottomNavigationBarItem(label: 'Task', icon: Icon(Icons.task_alt_rounded)),
                      BottomNavigationBarItem(
                        label: 'Statistics',
                        icon: Icon(Icons.bar_chart_rounded, color: ColorClass.disable),
                      ),
                      BottomNavigationBarItem(label: 'Setting', icon: Icon(Icons.settings_rounded)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: widget.child,
        ),
      ),
    );
  }
}
