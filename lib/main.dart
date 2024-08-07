import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:isar/isar.dart';
import 'package:mandalart/app.dart';
import 'package:mandalart/db/isar_db.dart';

late Isar isar;

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await MobileAds.instance.initialize();

  isar = await IsarDB().init();

  runApp(const App());
}
