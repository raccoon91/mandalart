import 'package:flutter/material.dart';

class BottomSheetPage<T> extends Page<T> {
  final bool useSafeArea;
  final bool showDragHandle;
  final Widget child;

  const BottomSheetPage({
    super.key,
    this.useSafeArea = true,
    this.showDragHandle = false,
    required this.child,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return ModalBottomSheetRoute<T>(
      settings: this,
      useSafeArea: useSafeArea,
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      backgroundColor: Colors.white,
      builder: (context) => child,
    );
  }
}
