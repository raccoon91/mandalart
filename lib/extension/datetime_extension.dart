extension DatetimeExtension on DateTime {
  int get timeToNum {
    var date = this;

    int hour = date.hour;
    int minute = date.minute;

    return (hour * 60) + minute;
  }

  int get weekOfMonth {
    var date = this;

    final firstDayOfTheMonth = DateTime(date.year, date.month, 1);

    int sum = firstDayOfTheMonth.weekday - 1 + date.day;

    if (sum % 7 == 0) {
      return sum ~/ 7;
    } else {
      return sum ~/ 7 + 1;
    }
  }
}
