import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/layout/screen_layout.dart';

class BottomNavigationLayout extends StatelessWidget {
  final String? title;
  final String? screenName;
  final StatefulNavigationShell child;

  const BottomNavigationLayout({
    super.key,
    this.title,
    this.screenName,
    required this.child,
  });

  bottomItemTapped(index) {
    if (index != 0) return;

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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        height: 100.h,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50.r)),
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
    );
  }
}
