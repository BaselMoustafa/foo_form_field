part of '../exporter.dart';

/// Concrete field controller that works with identical field/client types.
class ValueFieldController<T> extends FooFieldController<T, T> {
  /// Uses `SameValueMapper` so no conversion is required between layers.
  ValueFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
    required super.areEqual,
  }) : super(mapper: SameValueMapper<T>());

  static ValueFieldController<T> fromRangeController<T>({
    required bool isMin,
    required RangeFieldController<T> rangeController,
  }) {
    return ValueFieldController<T>(
      forcedErrorText: null,
      areEqual: rangeController.areEqualValues,
      initialValue: isMin ? rangeController.value?.min : rangeController.value?.max ,
      enabled: rangeController.enabled,
    );
  }
}
