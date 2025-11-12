part of 'exporter.dart';

class Range<T> {
  
  final T? min;
  final T? max;

  final bool Function(T x, T y) areEqual;

  const Range({
    required this.min,
    required this.max,
    required this.areEqual,
  });

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! Range<T>) {
      return false;
    }
    if (min == null && other.min == null) {
      return true;
    }
    if (min == null && other.min != null) {
      return false;
    }
    if (min != null && other.min == null) {
      return false;
    }
    if (max == null && other.max == null) {
      return true;
    }
    if (max == null && other.max != null) {
      return false;
    }
    if (max != null && other.max == null) {
      return false;
    }
    return areEqual(min as T, other.min as T) && areEqual(max as T, other.max as T);
  }
  
  @override
  String toString() {
    return "Range(min: $min, max: $max)";
  }
}

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

    if (firstIsBiggerThanSecond(value.min as T, value.max as T)) {
      return minBiggerThanMaxMessage;
    }

    return null;
  }

  String? validateEquality(Range<T> value){
    if (allowEqual || value.min == null || value.max == null) {
      return null;
    }
    if (value.areEqual(value.min as T, value.max as T)) {
      return equalMinAndMaxMessage;
    }

    return null;
  }

}