import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarData extends CalendarDataSource {
  CalendarData(List<Appointment> source) {
    appointments = source;
  }
}
