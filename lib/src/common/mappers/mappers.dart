
class Mapper<Value, FieldValue> {
  final Value? Function(FieldValue? i) toValue;
  final FieldValue? Function(Value? o) toFieldValue;

  const Mapper({
    required this.toValue,
    required this.toFieldValue,
  });

  static Mapper<Value, Value> sameValueMapper<Value>() {
    return Mapper<Value, Value>(
      toValue: (i) => i,
      toFieldValue: (o) => o,
    );
  }
}


class IntToStringMapper extends Mapper<int, String> {
  
  IntToStringMapper():super(
    toValue: (String? fieldValue) => int.tryParse(fieldValue ?? ''),
    toFieldValue: (int? value) => value?.toString(),
  );
  
}

