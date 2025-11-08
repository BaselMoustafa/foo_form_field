import 'range.dart';

class RangeValidator<T> {
  final bool Function(T first , T second) firstIsBiggerThanSecond;
  final bool Function(T x , T y) areEqual;

  final bool allowEqual;
  final String maxSmallerThanMinMessage;
  final String minBiggerThanMaxMessage;
  final String equalMinAndMaxMessage;

  RangeValidator({
    required this.firstIsBiggerThanSecond,
    required this.areEqual,
    this.allowEqual = false,
    this.maxSmallerThanMinMessage = "Smaller than min",
    this.minBiggerThanMaxMessage = "Bigger than max",
    this.equalMinAndMaxMessage = "Equal to min and max",
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

  String? validateMax(Range<T?> value){
    if (value.min == null || value.max == null) {
      return null;
    }

    if (firstIsBiggerThanSecond(value.min!, value.max!)) {
      return maxSmallerThanMinMessage;
    }

    return null;
  }

  String? validateEquality(Range<T?> value){
    if (allowEqual || value.min == null || value.max == null) {
      return null;
    }

    if (areEqual(value.min!, value.max!)) {
      return equalMinAndMaxMessage;
    }

    return null;
  }

}