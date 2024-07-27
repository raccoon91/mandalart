import 'package:flutter/material.dart';

class CreateMainTargetScreen extends StatelessWidget {
  const CreateMainTargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
