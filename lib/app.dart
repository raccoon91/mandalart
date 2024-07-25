import 'package:flutter/material.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeClass.theme,
      home: const HomeScreen(),
    );
  }
}
