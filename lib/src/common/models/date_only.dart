class DateOnly implements Comparable<DateOnly> {
  
  final int year;
  final int month;
  final int day;

  DateOnly({
    required this.year, 
    required this.month, 
    required this.day,
  }): assert(year >0, "Year must be greater than 0"),
    assert(month >0 && month <= 12, "Month must be between 1 and 12"),
    assert(day >0 && day <= 31, "Day must be between 1 and 31");

  factory DateOnly.fromDateTime(DateTime dateTime) {
    return DateOnly(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  DateTime toDateTime() {
    return DateTime(year, month, day);
  }

  @override
  int compareTo(DateOnly other) {
    if (year != other.year) {
      return year.compareTo(other.year);
    }
    if (month != other.month) {
      return month.compareTo(other.month);
    }
    return day.compareTo(other.day);
  }

  @override
  bool operator ==(covariant DateOnly other) {
    return compareTo(other)==0;
  }

  bool operator >(DateOnly other) {
    return compareTo(other) > 0;
  }

  bool operator >=(DateOnly other) {
    return compareTo(other) >= 0;
  }

  bool operator <=(DateOnly other) {
    return compareTo(other) <= 0;
  }

  bool operator <(DateOnly other) {
    return compareTo(other) < 0;
  }

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;

}