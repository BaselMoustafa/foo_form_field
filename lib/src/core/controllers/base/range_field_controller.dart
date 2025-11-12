part of '../exporter.dart';

class RangeFieldController<T,B extends RangeBoundryFieldController<T>> extends ConvertableRangeFieldController<T,T,B> {
  RangeFieldController({
    required super.areEqualValues,
    required super.minBoundryControllerBuilder,
    required super.maxBoundryControllerBuilder,
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }):super(
    valueMapper: SameValueMapper<T>(),
  );
}
