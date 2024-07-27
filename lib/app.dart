import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/screen/create_main_target_screen.dart';
import 'package:mandalart/screen/home_screen.dart';
import 'package:mandalart/screen/project_create_screen.dart';
import 'package:mandalart/screen/project_start_screen.dart';
import 'package:mandalart/theme/theme.dart';
import 'package:provider/provider.dart';

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/project',
      builder: (BuildContext context, GoRouterState state) {
        return const ProjectStartScreen();
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
                });
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
