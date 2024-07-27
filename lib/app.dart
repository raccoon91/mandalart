import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/screen/create_main_target_screen.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/screen/project_create_screen.dart';
import 'package:mandalart/screen/project_start_screen.dart';
import 'package:mandalart/screen/setting_screen.dart';
import 'package:mandalart/theme/theme.dart';
import 'package:mandalart/widget/base/bottom_navigation_page.dart';
import 'package:provider/provider.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeTabNavigatorKey = GlobalKey<NavigatorState>();
final _settingTabNavigatorKey = GlobalKey<NavigatorState>();

Page getPage({
  required Widget child,
  required GoRouterState state,
}) {
  return MaterialPage(
    key: state.pageKey,
    child: child,
  );
}

final GoRouter _router = GoRouter(
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
              pageBuilder: (context, GoRouterState state) {
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
              pageBuilder: (context, GoRouterState state) {
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
            title: state.name,
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
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ProjectCreateScreen(),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return SlideTransition(
                  position: animation.drive(
                    Tween(
                      begin: const Offset(1.5, 0),
                      end: Offset.zero,
                    ).chain(
                      CurveTween(curve: Curves.ease),
                    ),
                  ),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/create-main-target',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateMainTargetScreen();
      },
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp.router(
        theme: ThemeClass.theme,
        routerConfig: _router,
      ),
    );
  }
}
