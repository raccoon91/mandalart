import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mandalart/app.dart';
import 'package:mandalart/db/isar_db.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await IsarDB().init();

  FlutterNativeSplash.remove();

  runApp(const App());
}
