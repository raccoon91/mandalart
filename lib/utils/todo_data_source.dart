import 'package:syncfusion_flutter_calendar/calendar.dart';

class TodoDataSource extends CalendarDataSource {
  TodoDataSource(List<Appointment> source) {
    appointments = source;
  }
}
