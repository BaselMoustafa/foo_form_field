import 'package:foo_form_field/foo_form_field.dart';

class IntRangeValidator extends RangeValidator<int> {
  IntRangeValidator({
    bool Function(int x, int y)? firstIsBiggerThanSecond,
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: firstIsBiggerThanSecond?? (int x, int y) => x > y,
  );
} 