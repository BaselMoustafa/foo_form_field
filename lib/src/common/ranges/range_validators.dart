import '../../../foo_form_field.dart';

class RangeValidator<T> {
  final bool Function(T x, T y) firstIsBiggerThanSecond;
  final bool allowEqual;
  final String minBiggerThanMaxMessage;
  final String equalMinAndMaxMessage;

  const RangeValidator({
    required this.firstIsBiggerThanSecond,
    this.allowEqual = false,
    this.minBiggerThanMaxMessage = "Min value is bigger than max value",
    this.equalMinAndMaxMessage = "Min is equal to max value",
  });

  String? validateMin(Range<T?> value) {
    if (value.min == null || value.max == null) {
      return null;
    }

    if (firstIsBiggerThanSecond(value.min as T, value.max as T)) {
      return minBiggerThanMaxMessage;
    }

    return null;
  }

  String? validateEquality(Range<T> value) {
    if (allowEqual || value.min == null || value.max == null) {
      return null;
    }
    if (value.areEqual(value.min as T, value.max as T)) {
      return equalMinAndMaxMessage;
    }

    return null;
  }
}

class IntRangeValidator extends RangeValidator<int> {
  IntRangeValidator({
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: (int x, int y) => x > y,
  );
}

class NumRangeValidator extends RangeValidator<num> {
  NumRangeValidator({
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: (num x, num y) => x > y,
  );
}