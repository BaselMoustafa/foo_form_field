
import '../../../foo_form_field.dart';

class Range<T> {
  final T? min;
  final T? max;

  final bool Function(T x, T y) areEqual;

  const Range({required this.min, required this.max, required this.areEqual});

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
    return areEqual(min as T, other.min as T) &&
        areEqual(max as T, other.max as T);
  }

  @override
  String toString() {
    return "Range(min: $min, max: $max)";
  }
}

class IntRange extends Range<int> {
  IntRange({
    required super.min, 
    required super.max, 
  }):super(
    areEqual: (int x, int y) => x == y,
  );
}

class NumRange extends Range<num> {
  NumRange({
    required super.min, 
    required super.max, 
  }):super(
    areEqual: (num x, num y) => x == y,
  );
}

class DateTimeRange extends Range<DateTime> {
  DateTimeRange({
    required super.min, 
    required super.max, 
    bool Function(DateTime x, DateTime y)? areEqual,
  }):super(
    areEqual: areEqual ?? (DateTime x, DateTime y) => x.year == y.year && x.month == y.month && x.day == y.day && x.hour == y.hour && x.minute == y.minute,
  );
}

class DateOnlyRange extends Range<DateOnly> {
  DateOnlyRange({
    required super.min, 
    required super.max, 
    bool Function(DateOnly x, DateOnly y)? areEqual,
  }):super(
    areEqual: areEqual ?? (DateOnly x, DateOnly y) => x == y,
  );
}

