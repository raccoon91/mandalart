extension NumberFormatExtension on num {
  int toHour() {
    int hour = this ~/ 60;

    return hour;
  }

  int toMinute() {
    int minute = this % 60 as int;

    return minute;
  }
}
