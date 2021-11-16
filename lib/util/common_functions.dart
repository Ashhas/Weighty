class CommonFunctions {
  static bool isToday(DateTime dateToCheck) {
    return DateTime.now().year == dateToCheck.year &&
        DateTime.now().month == dateToCheck.month &&
        DateTime.now().day == dateToCheck.day;
  }
}
