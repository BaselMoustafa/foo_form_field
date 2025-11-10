import 'package:foo_form_field/src/core/ranges/range.dart';

class NumRange extends Range<num> {
  NumRange({
    required super.min,
    required super.max,
  }):super(
    areEqual: (num x, num y) => x == y,
  );
}