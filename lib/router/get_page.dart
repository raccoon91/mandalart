import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page getPage({
  required GoRouterState state,
  required Widget child,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}
