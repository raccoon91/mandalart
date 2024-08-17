import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';

class BottomNavigationLayout extends StatefulWidget {
  final String? title;
  final int? branchIndex;
  final StatefulNavigationShell child;

  const BottomNavigationLayout({
    super.key,
    this.title,
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
    widget.child.goBranch(
      index,
      initialLocation: index == widget.child.currentIndex,
    );
  }

  void onPopInvoked(bool didPop) {
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
    bool isHome =
        GoRouter.of(context).routeInformationProvider.value.uri.toString() ==
            '/home';

    return PopScope(
      canPop: false,
      onPopInvoked: onPopInvoked,
      child: ScreenLayout(
        title: widget.title,
        showFloatingAction: isHome,
        bottomNavigationBar: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.branchIndex == 0 ? 80.h : 60.h,
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 200),
            padding: widget.branchIndex == 0
                ? EdgeInsets.only(right: 20.w, bottom: 20.h, left: 20.w)
                : const EdgeInsets.all(0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                widget.branchIndex == 0
                    ? Radius.circular(50.r)
                    : const Radius.circular(0),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: ColorClass.under,
                  primaryColor: ColorClass.blue,
                ),
                child: BottomNavigationBar(
                  currentIndex: widget.child.currentIndex,
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  backgroundColor: ColorClass.under,
                  selectedItemColor: ColorClass.blue,
                  unselectedItemColor: ColorClass.border,
                  onTap: bottomItemTapped,
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home_filled),
                    ),
                    BottomNavigationBarItem(
                      label: 'Schedule',
                      icon: Icon(Icons.event_available),
                    ),
                    BottomNavigationBarItem(
                      label: 'Task',
                      icon: Icon(Icons.task_alt),
                    ),
                    BottomNavigationBarItem(
                      label: 'Setting',
                      icon: Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: widget.child,
      ),
    );
  }
}
