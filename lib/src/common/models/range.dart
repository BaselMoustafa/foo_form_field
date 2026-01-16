
import '../extentions/comparable_extension.dart';

class Range<T extends Comparable> {

  final T? min;
  final T? max;
  
  const Range({
    required this.min, 
    required this.max,
  });

  @override
  int get hashCode => min.hashCode ^ max.hashCode;

  @override
  bool operator ==(covariant Range<T> other) {
    return _equalMin(other) && _equalMax(other);
  }

  bool _equalMax(Range<T> other) {
    if (max == null && other.max != null) {
      return false;
    }
    if (max != null && other.max == null) {
      return false;
    }
    if (max == null && other.max == null) {
      return true;
    }
    return max!.isEqualTo(other.max as T);
  }

  bool _equalMin(Range<T> other) {
    if (min == null && other.min != null) {
      return false;
    }
    if (min != null && other.min == null) {
      return false;
    }
    if (min == null && other.min == null) {
      return true;
    }
    return min!.isEqualTo(other.min as T);
  }

  @override
  String toString() {
    return "Range(min: $min, max: $max)";
  }
}

class RangeValidator{
  final bool allowEqual;
  final String minBiggerThanMaxMessage;
  final String equalMinAndMaxMessage;

  const RangeValidator({
    this.allowEqual = false,
    this.minBiggerThanMaxMessage = "Min value is bigger than max value",
    this.equalMinAndMaxMessage = "Min is equal to max value",
  });

  String? validateMin(Range value) {
    if (value.min == null || value.max == null) {
      return null;
    }

    if (value.min!.isGreaterThan(value.max!)) {
      return minBiggerThanMaxMessage;
    }

    return null;
  }

  String? validateEquality(Range value) {
    if (allowEqual || value.min == null || value.max == null) {
      return null;
    }
    if (value.min!.isEqualTo(value.max!)) {
      return equalMinAndMaxMessage;
    }

    return null;
  }
}
