extension NumberExtension on num {
  int get numToHour {
    int hour = this ~/ 60;

    return hour;
  }

  int get numToMinute {
    int minute = this % 60 as int;

    return minute;
  }

  String toFileSize({int round = 2, bool useBase1024 = true}) {
    const List<String> affixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];

    num divider = useBase1024 ? 1024 : 1000;

    num size = this;
    num runningDivider = divider;
    num runningPreviousDivider = 0;
    int affix = 0;

    while (size >= runningDivider && affix < affixes.length - 1) {
      runningPreviousDivider = runningDivider;
      runningDivider *= divider;
      affix++;
    }

    String result =
        (runningPreviousDivider == 0 ? size : size / runningPreviousDivider)
            .toStringAsFixed(round);

    if (result.endsWith('0' * round)) {
      result = result.substring(0, result.length - round - 1);
    }

    return '$result ${affixes[affix]}';
  }
}
