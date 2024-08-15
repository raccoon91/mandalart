import 'package:mandalart/model/todo_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodoDataSource extends CalendarDataSource {
  TodoDataSource(List<TodoModel> source) {
    appointments = source;
  }
}
