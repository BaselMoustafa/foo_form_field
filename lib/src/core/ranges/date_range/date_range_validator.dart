import 'package:foo_form_field/foo_form_field.dart';

class DateRangeValidator extends RangeValidator<DateTime> {
  DateRangeValidator({
    bool Function(DateTime x, DateTime y)? firstIsBiggerThanSecond,
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: firstIsBiggerThanSecond?? (DateTime x, DateTime y) => x.year>y.year||x.month>y.month||x.day>y.day,
  );
} 