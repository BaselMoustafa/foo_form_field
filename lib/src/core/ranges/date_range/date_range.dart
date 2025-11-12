import 'package:foo_form_field/src/core/ranges/range/range.dart';

class DateRange extends Range<DateTime> {
  DateRange({
    required super.min,
    required super.max,
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqual: areEqual?? (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day,
  );
}