part of '../exporter.dart';

/// Controller bridging `int` client values with `String` form field values.
class IntStringFieldController extends FooFieldController<int, String> {
  IntStringFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(areEqual: (int x, int y) => x == y, mapper: IntStringMapper());
}

class IntStringRangeFieldController extends ConvertableRangeFieldController<int, String> {
  IntStringRangeFieldController({
    super.initialValue,
    super.enabled,
    super.forcedErrorText,
  }) : super(
    valueMapper: IntStringMapper(),
    areEqualValues: (int x, int y) => x == y,
  );
}
