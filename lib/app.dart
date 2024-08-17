import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandalart/provider/calendar_provider.dart';
import 'package:mandalart/provider/goal_provider.dart';
import 'package:mandalart/provider/home_provider.dart';
import 'package:mandalart/provider/setting_provider.dart';
import 'package:mandalart/provider/task_provider.dart';
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
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => SettingProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(480, 800),
        minTextAdapt: true,
        child: MaterialApp.router(
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko'),
          ],
          locale: const Locale('ko'),
          theme: ThemeClass.theme,
          routerConfig: router,
        ),
      ),
    );
  }
}
