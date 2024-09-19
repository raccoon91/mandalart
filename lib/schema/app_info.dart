import 'package:isar/isar.dart';

part 'app_info.g.dart';

@collection
class AppInfo {
  Id id = Isar.autoIncrement;

  late String version;

  late String appVersion;

  late String buildNumber;
}
