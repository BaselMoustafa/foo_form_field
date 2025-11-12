part of 'exporter.dart';

class IntRange extends Range<int> {
  IntRange({
    required super.min,
    required super.max,
  }):super(
    areEqual: (int x, int y) => x == y,
  );
}

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