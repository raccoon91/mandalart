import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/create_main_target_screen.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/screen/project_create_screen.dart';
import 'package:mandalart/screen/project_start_screen.dart';
import 'package:mandalart/screen/setting_screen.dart';
import 'package:mandalart/widget/base/bottom_navigation_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
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
          child: BottomNavigationPage(
            child: navigationShell,
          ),
        );
      },
    ),
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
              child: const ProjectCreateScreen(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/create-main-target',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          child: const CreateMainTargetScreen(),
        );
      },
    ),
  ],
);
