class FieldValueMapper<O,I> {
  final O? Function(I? i) toClientType;
  final I? Function(O? o) toFieldType;

  FieldValueMapper({
    required this.toClientType,
    required this.toFieldType,
  });
}