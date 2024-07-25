import 'package:mandalart/model/main_target_model.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectModel {
  int id;
  String? name;
  bool isDefault;
  List<MainTargetModel>? mainTargets;

  ProjectModel({
    required this.id,
    this.name,
    required this.isDefault,
    this.mainTargets,
  });

  factory ProjectModel.fromJson(Project schema) {
    var mainTargets = schema.mainTargets.map(MainTargetModel.fromJson).toList();

    return ProjectModel(
      id: schema.id,
      name: schema.name,
      isDefault: schema.isDefault,
      mainTargets: mainTargets,
    );
  }
}
