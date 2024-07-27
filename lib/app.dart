import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/screen/create_main_target_screen.dart';
import 'package:mandalart/screen/home_screen.dart';
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
