import 'package:flutter/material.dart';
import 'package:mandalart/app.dart';
import 'package:mandalart/db/isar_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await IsarDB().init();

  runApp(const App());
}
