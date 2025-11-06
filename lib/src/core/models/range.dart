class Range<T> {
  
  final T? min;
  final T? max;

  const Range({
    required this.min,
    required this.max,
  });
  
  Range<T> copyWith({
    T? min,
    T? max,
  }){
    return Range<T>(
      min: min ?? this.min,
      max: max ?? this.max,
    );
  }

  Range<T> changeMin(T? min){
    return copyWith(min: min);
  }

  Range<T> changeMax(T? max){
    return copyWith(max: max);
  }
}