import 'package:foo_form_field/src/core/ranges/range.dart';

class DateRange extends Range<DateTime> {
  DateRange({
    required super.min,
    required super.max,
    bool Function(DateTime x, DateTime y)? areEqual,
    bool Function(DateTime x, DateTime y)? firstIsBiggerThanSecond,
  }):super(
    areEqual: areEqual?? (DateTime x, DateTime y) => x.isAtSameMomentAs(y),
  );
}