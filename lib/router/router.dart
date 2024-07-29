import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/screen/plan_create_screen.dart';
import 'package:mandalart/screen/project_create_screen.dart';
import 'package:mandalart/screen/project_start_screen.dart';
import 'package:mandalart/screen/setting_screen.dart';
import 'package:mandalart/widget/base/bottom_navigation_layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

final bottomNavigationRoutes = StatefulShellRoute.indexedStack(
  parentNavigatorKey: _rootNavigatorKey,
  branches: [
    StatefulShellBranch(
      navigatorKey: _homeTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const HomeScreen(),
            );
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _settingTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/setting',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const SettingScreen(),
            );
          },
        ),
      ],
    ),
  ],
  pageBuilder: (
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return getPage(
      state: state,
      child: BottomNavigationLayout(
        child: navigationShell,
      ),
    );
  },
);

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    bottomNavigationRoutes,
    GoRoute(
      path: '/project',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return getPage(
          state: state,
          child: const ProjectStartScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'create',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return slideTransitionPage(
              state: state,
              child: const ProjectCreateScreen(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/main-target/create',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: PlanCreateScreen(
            projectId: state.uri.queryParameters['projectId'],
            planId: state.uri.queryParameters['planId'],
          ),
        );
      },
    ),
  ],
);
