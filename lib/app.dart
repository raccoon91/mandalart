import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/plan_provider.dart';
import 'package:mandalart/router/router.dart';
import 'package:mandalart/theme/theme.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => PlanProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(480, 800),
        minTextAdapt: true,
        child: MaterialApp.router(
          theme: ThemeClass.theme,
          routerConfig: router,
        ),
      ),
    );
  }
}
