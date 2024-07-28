import 'package:flutter/material.dart';

class MainTargetCreateScreen extends StatelessWidget {
  const MainTargetCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("목표 생성"),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Center(
          child: Text("create"),
        ),
      ),
    );
  }
}
