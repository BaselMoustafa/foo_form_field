import 'package:foo_form_field/foo_form_field.dart';

class NumRangeValidator extends RangeValidator<num> {
  NumRangeValidator({
    bool Function(num x, num y)? firstIsBiggerThanSecond,
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: firstIsBiggerThanSecond?? (num x, num y) => x > y,
  );
} 