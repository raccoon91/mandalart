import 'package:flutter/foundation.dart';
import 'package:mandalart/model/plan_model.dart';
import 'package:mandalart/model/project_model.dart';
import 'package:mandalart/repository/project_repository.dart';

class CalendarProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _isEmpty = true;
  bool _isLoading = false;
  List<PlanModel?>? _plans;

  bool get isEmpty => _isEmpty;
  bool get isLoading => _isLoading;
  List<PlanModel?>? get plans => _plans;

  Future<void> getPlans() async {
    try {
      _isLoading = true;

      notifyListeners();

      ProjectModel? project = await ProjectRepository().getProject();

      _isEmpty =
          project == null || project.plans == null || project.plans!.isEmpty;

      _plans = project?.plans
          ?.where((plan) => plan?.name?.isNotEmpty ?? false)
          .toList();
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<List<PlanModel?>>('plans', _plans));
  }
}
