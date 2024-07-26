import 'package:isar/isar.dart';
import 'package:mandalart/db/isar_db.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/schema/project_schema.dart';

class ProjectRepository {
  ProjectRepository();

  Future<ProjectModel?> getProject() async {
    final projectSchema =
        await IsarDB.isar.projects.filter().isDefaultEqualTo(true).findFirst();

    if (projectSchema == null) return null;

    final project = ProjectModel.fromJson(projectSchema);

    return project;
  }

  Future<ProjectModel> createProject(String name) async {
    final projectSchema = Project()
      ..name = name
      ..isDefault = true;

    await IsarDB.isar.writeTxn(() async {
      await IsarDB.isar.projects.put(projectSchema);
    });

    final project = ProjectModel.fromJson(projectSchema);

    return project;
  }
}
