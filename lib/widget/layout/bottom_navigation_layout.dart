import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';

class BottomNavigationLayout extends StatelessWidget {
  final String? title;
  final int? branchIndex;
  final String? screenName;
  final StatefulNavigationShell child;

  const BottomNavigationLayout({
    super.key,
    this.title,
    this.branchIndex,
    this.screenName,
    required this.child,
  });

  bottomItemTapped(index) {
    child.goBranch(
      index,
      initialLocation: index == child.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      title: title,
      body: child,
      showFloatingAction: screenName == 'home',
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: branchIndex == 0 ? 80.h : 60.h,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 200),
          padding: branchIndex == 0
              ? EdgeInsets.only(right: 20.w, bottom: 20.h, left: 20.w)
              : const EdgeInsets.all(0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              branchIndex == 0
                  ? Radius.circular(50.r)
                  : const Radius.circular(0),
            ),
            child: BottomNavigationBar(
              currentIndex: child.currentIndex,
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
                  icon: SizedBox(
                    child: Icon(Icons.home_filled),
                  ),
                ),
                BottomNavigationBarItem(
                  label: 'Calendar',
                  icon: Icon(Icons.event_available),
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
    );
  }
}
