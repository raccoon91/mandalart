import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/theme/color.dart';

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
    return Scaffold(
      appBar: title == null
          ? null
          : AppBar(
              centerTitle: true,
              title: Text(title ?? ""),
            ),
      body: SafeArea(child: child),
      backgroundColor: ColorClass.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: child.currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorClass.blue,
        unselectedItemColor: ColorClass.gray,
        backgroundColor: ColorClass.white,
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
