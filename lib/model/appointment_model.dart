import 'package:mandalart/model/schedule_model.dart';
import 'package:mandalart/theme/color.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentModel extends Appointment {
  int? scheduleId;

  AppointmentModel({
    required super.subject,
    required super.startTime,
    required super.endTime,
    required super.isAllDay,
    required super.color,
    this.scheduleId,
  });

  factory AppointmentModel.fromSchema(ScheduleModel schedule) {
    return AppointmentModel(
      scheduleId: schedule.id,
      subject: schedule.plan?.name ?? '',
      startTime: schedule.from,
      endTime: schedule.to,
      isAllDay: schedule.isAllDay,
      color: schedule.color ?? ColorClass.under,
    );
  }
}
