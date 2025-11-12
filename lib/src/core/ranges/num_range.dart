part of 'exporter.dart';

class NumRange extends Range<num> {
  NumRange({
    required super.min,
    required super.max,
  }):super(
    areEqual: (num x, num y) => x == y,
  );
}

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