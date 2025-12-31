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

class DateTimeRangeValidator extends RangeValidator<DateTime> {
  DateTimeRangeValidator({
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
    bool Function(DateTime first, DateTime second)? firstIsBiggerThanSecond,
  }):super(
    firstIsBiggerThanSecond:firstIsBiggerThanSecond ?? (DateTime first, DateTime second){
      if(first.year > second.year) {
        return true;
      }
      if(first.year < second.year) {
        return false;
      }
      if(first.month > second.month) {
        return true;
      }
      if(first.month < second.month) {
        return false;
      }
      if(first.day > second.day) {
        return true;
      }
      if(first.day < second.day) {
        return false;
      }
      if(first.hour > second.hour) {
        return true;
      }
      if(first.hour < second.hour) {
        return false;
      }
      if(first.minute > second.minute) {
        return true;
      }
      return false;
    },
  );
}

class DateOnlyRangeValidator extends RangeValidator<DateOnly> {
  DateOnlyRangeValidator({
    super.allowEqual,
    super.minBiggerThanMaxMessage,
    super.equalMinAndMaxMessage,
  }):super(
    firstIsBiggerThanSecond: (DateOnly first, DateOnly second){
      return first > second;
    },
  );
}