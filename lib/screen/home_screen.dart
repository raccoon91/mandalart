import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(''),
              ),
            ),
          ),
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(''),
              ),
            ),
          ),
          Flexible(
            child: AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: Text(''),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
