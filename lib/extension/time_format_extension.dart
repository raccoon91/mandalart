extension TimeFormatExtension on DateTime {
  int get timeToNum {
    int hour = this.hour;
    int minute = this.minute;

    return (hour * 60) + minute;
  }
}
