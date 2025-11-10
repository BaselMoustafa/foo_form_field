import 'package:foo_form_field/src/core/ranges/range.dart';

class IntRange extends Range<int> {
  IntRange({
    required super.min,
    required super.max,
  }):super(
    areEqual: (int x, int y) => x == y,
  );
}