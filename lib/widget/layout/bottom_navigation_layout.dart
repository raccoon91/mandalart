import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(20),
        height: 90,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                label: 'Setting',
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
