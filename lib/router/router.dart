import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/router/bottom_sheet_page.dart';
import 'package:mandalart/router/get_page.dart';
import 'package:mandalart/router/slide_transition_page.dart';
import 'package:mandalart/screen/home/goal_screen.dart';
import 'package:mandalart/screen/home/goal_template_create_screen.dart';
import 'package:mandalart/screen/home/goal_template_select_screen.dart';
import 'package:mandalart/screen/home/home_screen.dart';
import 'package:mandalart/screen/home/plan_template_create_screen.dart';
import 'package:mandalart/screen/home/plan_template_select_screen.dart';
import 'package:mandalart/screen/schedule/schedule_bottom_sheet_screen.dart';
import 'package:mandalart/screen/schedule/schedule_create_bottom_sheet_screen.dart';
import 'package:mandalart/screen/schedule/schedule_screen.dart';
import 'package:mandalart/screen/setting/setting_screen.dart';
import 'package:mandalart/screen/setting/setting_storage_screen.dart';
import 'package:mandalart/screen/statistics/statistics_screen.dart';
import 'package:mandalart/screen/task/task_screen.dart';
import 'package:mandalart/screen/vision/vision_create_screen.dart';
import 'package:mandalart/screen/vision/vision_start_screen.dart';
import 'package:mandalart/widget/layout/bottom_navigation_layout.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _scheduleNavigatorKey = GlobalKey<NavigatorState>();
final _taskNavigatorKey = GlobalKey<NavigatorState>();
final _statisticsNavigatorKey = GlobalKey<NavigatorState>();
final _settingNavigatorKey = GlobalKey<NavigatorState>();

final bottomNavigationRoutes = StatefulShellRoute.indexedStack(
  parentNavigatorKey: _rootNavigatorKey,
  branches: [
    StatefulShellBranch(
      navigatorKey: _homeNavigatorKey,
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
      navigatorKey: _scheduleNavigatorKey,
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
      navigatorKey: _taskNavigatorKey,
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
      navigatorKey: _statisticsNavigatorKey,
      routes: [
        GoRoute(
          path: '/statistics',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return getPage(
              state: state,
              child: const StatisticsScreen(),
            );
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: _settingNavigatorKey,
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
      parentNavigatorKey: _rootNavigatorKey,
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
      parentNavigatorKey: _rootNavigatorKey,
      path: '/template/goal/create',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: const GoalTemplateCreateScreen(),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/template/goal/:goalId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: GoalTemplateSelectScreen(
            goalId: state.pathParameters['goalId'],
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/template/goal/:goalId/plan/create',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: PlanTemplateCreateScreen(
            goalId: state.pathParameters['goalId'],
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/template/goal/:goalId/plan/:planId',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return slideTransitionPage(
          state: state,
          child: PlanTemplateSelectScreen(
            goalId: state.pathParameters['goalId'],
            planId: state.pathParameters['planId'],
          ),
        );
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
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
      parentNavigatorKey: _rootNavigatorKey,
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
      parentNavigatorKey: _rootNavigatorKey,
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
