import 'package:foo_form_field/src/core/ranges/range/range.dart';

class RangeValidator<T> {

  final bool Function(T x, T y) firstIsBiggerThanSecond;
  final bool allowEqual;
  final String minBiggerThanMaxMessage;
  final String equalMinAndMaxMessage;

  RangeValidator({
    required this.firstIsBiggerThanSecond,
    this.allowEqual = false,
    this.minBiggerThanMaxMessage = "Min value is bigger than max value",
    this.equalMinAndMaxMessage = "Min is equal to max value",
  });

  String? validateMin(Range<T?> value){
    if (value.min == null || value.max == null) {
      return null;
    }

    if (firstIsBiggerThanSecond(value.min!, value.max!)) {
      return minBiggerThanMaxMessage;
    }

    return null;
  }

  String? validateEquality(Range<T> value){
    if (allowEqual || value.min == null || value.max == null) {
      return null;
    }
    if (value.areEqual(value.min!, value.max!)) {
      return equalMinAndMaxMessage;
    }

    return null;
  }

}