import 'package:flutter/material.dart';
import 'package:mandalart/screens/home_screen.dart';
import 'package:mandalart/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeClass.theme,
      home: const HomeScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
