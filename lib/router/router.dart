import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/bottom_sheet_page.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/home/goal_create_bottom_sheet_screen.dart';
import 'package:mandalart/screen/home/goal_screen.dart';
import 'package:mandalart/screen/home/home_screen.dart';
import 'package:mandalart/screen/home/plan_create_bottom_sheet_screen.dart';
import 'package:mandalart/screen/schedule/schedule_bottom_sheet_screen.dart';
import 'package:mandalart/screen/schedule/schedule_create_bottom_sheet_screen.dart';
import 'package:mandalart/screen/schedule/schedule_screen.dart';
import 'package:mandalart/screen/setting/setting_screen.dart';
import 'package:mandalart/screen/setting/setting_storage_screen.dart';
import 'package:mandalart/screen/task/task_screen.dart';
import 'package:mandalart/screen/vision/vision_create_screen.dart';
import 'package:mandalart/screen/vision/vision_start_screen.dart';
import 'package:mandalart/widget/layout/bottom_navigation_layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _scheduleTabNavigatorKey = GlobalKey<NavigatorState>();
final _taskTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

final bottomNavigationRoutes = StatefulShellRoute.indexedStack(
  parentNavigatorKey: _rootNavigatorKey,
  branches: [
    StatefulShellBranch(
      navigatorKey: _homeTabNavigatorKey,
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const HomeScreen(),
            );
          },
          routes: [
            GoRoute(
              name: 'goal',
              path: 'goal/:goalId',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return slideTransitionPage(
                  state: state,
                  child: GoalScreen(
                    goalId: state.pathParameters['goalId'],
                  ),
                );
              },
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _scheduleTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/schedule',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const ScheduleScreen(),
            );
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _taskTabNavigatorKey,
      routes: [
        GoRoute(
          path: '/task',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const TaskScreen(),
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
      path: '/vision',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return getPage(
          state: state,
          child: const VisionStartScreen(),
        );
      },
      routes: [
        GoRoute(
          path: 'create',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return slideTransitionPage(
              state: state,
              child: const VisionCreateScreen(),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/sheet/goal/create/:goalId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: GoalCreateBottomSheetScreen(
            goalId: state.pathParameters['goalId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/plan/create/:mode/:goalId/:planId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: PlanCreateBottomSheetScreen(
            mode: state.pathParameters['mode'],
            goalId: state.pathParameters['goalId'],
            planId: state.pathParameters['planId'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/schedule/create/:date',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: ScheduleCreateBottomSheetScreen(
            date: state.pathParameters['date'],
          ),
        );
      },
    ),
    GoRoute(
      path: '/sheet/schedule/:scheduleId/:from/:to',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return BottomSheetPage(
          child: ScheduleBottomSheetScreen(
            scheduleId: state.pathParameters['scheduleId'],
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
