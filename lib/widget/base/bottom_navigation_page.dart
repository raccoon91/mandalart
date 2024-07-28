import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';
import 'package:mandalart/widget/base/layout.dart';

class BottomNavigationPage extends StatelessWidget {
  final String? title;
  final StatefulNavigationShell child;

  const BottomNavigationPage({
    super.key,
    this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: title,
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorClass.blue,
        unselectedItemColor: ColorClass.gray,
        backgroundColor: ColorClass.under,
        onTap: (index) {
          child.goBranch(
            index,
            initialLocation: index == child.currentIndex,
          );
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Setting',
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
