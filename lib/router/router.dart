import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/screen/plan_screen.dart';
import 'package:mandalart/screen/project_create_screen.dart';
import 'package:mandalart/screen/project_start_screen.dart';
import 'package:mandalart/screen/setting_screen.dart';
import 'package:mandalart/widget/base/bottom_navigation_layout.dart';

final screenIndexMap = {
  0: 'home',
  1: 'calendar',
  2: 'setting',
};

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
            routes: [
              GoRoute(
                path: ':planId',
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return getPage(
                    state: state,
                    child: PlanScreen(
                      planId: state.pathParameters['planId'],
                    ),
                  );
                },
              ),
            ]),
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
    String? screenName = screenIndexMap[navigationShell.currentIndex];

    return getPage(
      state: state,
      child: BottomNavigationLayout(
        screenName: screenName,
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
  ],
);
