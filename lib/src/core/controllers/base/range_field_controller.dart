part of '../exporter.dart';

/// Specialized range controller where the field and client value types are identical.
class RangeFieldController<T> extends ConvertableRangeFieldController<T, T> {
  /// Creates a range controller using `SameValueMapper` to avoid type conversions.
  RangeFieldController({
    required super.areEqualValues,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(valueMapper: SameValueMapper<T>());

  @override
  ValueFieldController<T> get minValueController{
    minController ??= ValueFieldController.fromRangeController<T>(
      isMin: true,
      rangeController: this,
    );
    return minController as ValueFieldController<T>;
  }

  @override
  ValueFieldController<T> get maxValueController{
    maxController ??= ValueFieldController.fromRangeController<T>(
      isMin: false,
      rangeController: this,
    );
    return maxController as ValueFieldController<T>;
  }
}
