import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/bottom_sheet_page.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/calendar/calendar_bottom_sheet_screen.dart';
import 'package:mandalart/screen/calendar/calendar_screen.dart';
import 'package:mandalart/screen/calendar/task_bottom_sheet_screen.dart';
import 'package:mandalart/screen/home/detailed_plan_bottom_sheet_screen.dart';
import 'package:mandalart/screen/home/home_screen.dart';
import 'package:mandalart/screen/home/plan_bottom_sheet_screen.dart';
import 'package:mandalart/screen/home/plan_screen.dart';
import 'package:mandalart/screen/project/project_create_screen.dart';
import 'package:mandalart/screen/project/project_start_screen.dart';
import 'package:mandalart/screen/setting/setting_screen.dart';
import 'package:mandalart/screen/setting/setting_storage_screen.dart';
import 'package:mandalart/widget/layout/bottom_navigation_layout.dart';

final screenPathMap = {
  '/home': 'home',
  '/calendar': 'calendar',
  '/setting': 'setting',
};

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _calendarTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

final bottomNavigationRoutes = StatefulShellRoute.indexedStack(
  parentNavigatorKey: _rootNavigatorKey,
  branches: [
    StatefulShellBranch(
      navigatorKey: _homeTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/home',
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
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _calendarTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/calendar',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const CalendarScreen(),
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
    String? screenName = screenPathMap[state.fullPath];

    return getPage(
      state: state,
      child: BottomNavigationLayout(
        screenName: screenName,
        branchIndex: navigationShell.currentIndex,
        child: navigationShell,
      ),
    );
  },
);

final GoRouter router = GoRouter(
  initialLocation: '/home',
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
      path: '/sheet/plan/:planId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: PlanBottomSheetScreen(
            planId: state.pathParameters['planId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/detailed/:mode/:planId/:detailedId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: DetailedPlanBottomSheetScreen(
            mode: state.pathParameters['mode'],
            planId: state.pathParameters['planId'],
            detailedPlanId: state.pathParameters['detailedId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/calendar/:date',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: CalendarBottomSheetScreen(
            date: state.pathParameters['date'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/task/:taskId/:from/:to',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: TaskBottomSheetScreen(
            taskId: state.pathParameters['taskId'],
            from: state.pathParameters['from'],
            to: state.pathParameters['to'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/setting/storage',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: const SettingStorageScreen(),
        );
      },
    ),
  ],
);
