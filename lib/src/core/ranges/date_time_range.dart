part of 'exporter.dart';

class DateTimeRange extends Range<DateTime> {
  DateTimeRange({
    required super.min,
    required super.max,
    bool Function(DateTime x, DateTime y)? areEqual,
  }) : super(
         areEqual:
             areEqual ??
             (DateTime x, DateTime y) =>
                 x.year == y.year && x.month == y.month && x.day == y.day,
       );
}

class DateTimeRangeValidator extends RangeValidator<DateTime> {
  DateTimeRangeValidator({
    bool Function(DateTime x, DateTime y)? firstIsBiggerThanSecond,
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }) : super(
         firstIsBiggerThanSecond:
             firstIsBiggerThanSecond ??
             (DateTime x, DateTime y) =>
                 x.year > y.year || x.month > y.month || x.day > y.day,
       );
}
